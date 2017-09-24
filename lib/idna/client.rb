require 'ffi'

module Idna
  class Client
    extend FFI::Library
    class << self
      def lib_load!
        ffi_lib Idna::Configure.ffi_lib

        attach_function :idna_to_ascii_8z, %i[string pointer int], :int
        attach_function :idna_to_unicode_8z8z, %i[string pointer int], :int
      end
    end

    def to_ascii(string, skip_useless: false)
      return unless string
      return string if skip_useless && string.ascii_only?

      pointer = FFI::MemoryPointer.new :pointer
      int = idna_to_ascii_8z(string, pointer, 0x0001)
      Idna::Error.handling(int) unless int == 0
      result = pointer.read_pointer.read_string
      pointer.free

      result
    end

    def to_unicode(string, skip_useless: false)
      return unless string
      return string if skip_useless && !string.ascii_only?

      pointer = FFI::MemoryPointer.new :pointer
      int = idna_to_unicode_8z8z(string, pointer, 0x0001)
      Idna::Error.handling(int) unless int == 0
      result = pointer.read_pointer.read_string
      pointer.free

      result.force_encoding('UTF-8')
    end
  end
end
