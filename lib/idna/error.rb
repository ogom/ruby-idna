module Idna
  class Error < StandardError
    class << self
      def handling(int)
        klass = case int
                when   1 then Idna::Error::IDNA_STRINGPREP_ERROR
                when   2 then Idna::Error::IDNA_PUNYCODE_ERROR
                when   3 then Idna::Error::IDNA_CONTAINS_NON_LDH
                when   4 then Idna::Error::IDNA_CONTAINS_MINUS
                when   5 then Idna::Error::IDNA_INVALID_LENGTH
                when   6 then Idna::Error::IDNA_NO_ACE_PREFIX
                when   7 then Idna::Error::IDNA_ROUNDTRIP_VERIFY_ERROR
                when   8 then Idna::Error::IDNA_CONTAINS_ACE_PREFIX
                when   9 then Idna::Error::IDNA_ICONV_ERROR
                when 201 then Idna::Error::IDNA_MALLOC_ERROR
                when 202 then Idna::Error::IDNA_DLOPEN_ERROR
                end
        raise klass.new message(int)
      end

      private

      def message(int)
        case int
        when   1 then 'Error during string preparation.'
        when   2 then 'Error during punycode operation.'
        when   3 then 'For IDNA_USE_STD3_ASCII_RULES, indicate that the string contains non-LDH ASCII characters.'
        when   4 then 'For IDNA_USE_STD3_ASCII_RULES, indicate that the string contains a leading or trailing hyphen-minus (U+002D).'
        when   5 then 'The final output string is not within the (inclusive) range 1 to 63 characters.'
        when   6 then 'The string does not contain the ACE prefix (for ToUnicode).'
        when   7 then 'The ToASCII operation on output string does not equal the input.'
        when   8 then 'The input contains the ACE prefix (for ToASCII).'
        when   9 then 'Could not convert string in locale encoding.'
        when 201 then 'Could not allocate buffer (this is typically a fatal error).'
        when 202 then 'Could not dlopen the libcidn DSO (only used internally in libc).'
        end
      end
    end
  end

  class Error::IDNA_STRINGPREP_ERROR        < Idna::Error; end
  class Error::IDNA_PUNYCODE_ERROR          < Idna::Error; end
  class Error::IDNA_CONTAINS_NON_LDH        < Idna::Error; end
  class Error::IDNA_CONTAINS_MINUS          < Idna::Error; end
  class Error::IDNA_INVALID_LENGTH          < Idna::Error; end
  class Error::IDNA_NO_ACE_PREFIX           < Idna::Error; end
  class Error::IDNA_ROUNDTRIP_VERIFY_ERROR  < Idna::Error; end
  class Error::IDNA_CONTAINS_ACE_PREFIX     < Idna::Error; end
  class Error::IDNA_ICONV_ERROR             < Idna::Error; end
  class Error::IDNA_MALLOC_ERROR            < Idna::Error; end
  class Error::IDNA_DLOPEN_ERROR            < Idna::Error; end
end
