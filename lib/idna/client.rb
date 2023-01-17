require 'ffi'

module Idna
  class Client

    # Simple domain matching regexps, validating basic structure:
    #
    # * 1-63 ASCII alphanumeric characters, dots, or hyphens, followed by a
    #   TLD specifier consisting of a dot, then 1 or more of any alphabetic
    #   ASCII characters - for full domains (e.g. "subdomain.example.com").
    #
    # * As above, but for single domain parts only (e.g. "example") and not
    #   intended for TLDs such as ".com" (character match is too permissive).
    #
    # Convert Unicode domains to ASCII before using these. See also #valid?.
    #
    ASCII_DOMAIN_FULL_REGEXP  = /^[A-Za-z0-9\-\.]{1,63}?\.[A-Za-z]+$/
    ASCII_DOMAIN_LIGHT_REGEXP = /^[A-Za-z0-9\-]{1,63}?$/

    extend FFI::Library
    class << self
      def lib_load!
        ffi_lib Idna::Configure.ffi_lib

        attach_function :idn2_to_ascii_8z, %i[string pointer int], :int
        attach_function :idn2_to_unicode_8z8z, %i[string pointer int], :int
      end
    end

    def to_ascii(string, skip_useless: false)
      return unless string
      return string if skip_useless && string.ascii_only?

      pointer = FFI::MemoryPointer.new :pointer
      int = idn2_to_ascii_8z(string, pointer, 0x0001)
      Idna::Error.handling(int) unless int == 0
      result = pointer.read_pointer.read_string
      pointer.free

      result
    end

    def to_unicode(string, skip_useless: false)
      return unless string
      return string if skip_useless && !string.ascii_only?

      pointer = FFI::MemoryPointer.new :pointer
      int = idn2_to_unicode_8z8z(string, pointer, 0x0001)
      Idna::Error.handling(int) unless int == 0
      result = pointer.read_pointer.read_string
      pointer.free

      result.force_encoding('UTF-8')
    end

    # Perform simple validation of the given domain, converting to ASCII first.
    # Returns +true+ if the basic structure looks valid, else +false+. Does not
    # check to see if e.g. a given TLD is actually a currently defined, allowed
    # value such as ".com" rather than ".asdfghjk"; it just makes sure the
    # character ranges used are permitted.
    #
    # +string+:: Domain - Unicode or ASCII.
    #
    # Options are:
    #
    # +components+:: Incorporates multiple components (e.g. "example.com" or
    #                "subdomain.example.com"), in which case the last domain
    #                (in both of these examples, that's ".com") must follow
    #                TLD rules and use alphabetic characters only. Default is
    #                +false+.
    #
    def valid?(string, components: false)
      return false unless string

      # Force conversion to/from UTF-8 (whether or not already in UTF-8 or just
      # ASCII) to check validity for those operations, then process the ASCII
      # result through an appropriate regular expression.

      string = to_unicode(string, skip_useless: false)
      string =   to_ascii(string, skip_useless: false)
      regexp = components ? ASCII_DOMAIN_FULL_REGEXP : ASCII_DOMAIN_LIGHT_REGEXP

      return string.match?(regexp)

    # Although some error conditions might not indicate a lack of valid input,
    # e.g. "out of memory", most do; this 'rescue' just keeps it simple.
    #
    rescue Idna::Error
      return false

    end
  end
end
