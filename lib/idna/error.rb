module Idna

  # Source:
  #
  #   https://gitlab.com/libidn/libidn2/-/blob/master/lib/idn2.h.in#L227
  #
  class Error < StandardError
    class << self
      def handling(int)
        klass = case int
                when    0 then Idna::Error::IDN2_OK
                when -100 then Idna::Error::IDN2_MALLOC
                when -101 then Idna::Error::IDN2_NO_CODESET
                when -102 then Idna::Error::IDN2_ICONV_FAIL
                when -200 then Idna::Error::IDN2_ENCODING_ERROR
                when -201 then Idna::Error::IDN2_NFC
                when -202 then Idna::Error::IDN2_PUNYCODE_BAD_INPUT
                when -203 then Idna::Error::IDN2_PUNYCODE_BIG_OUTPUT
                when -204 then Idna::Error::IDN2_PUNYCODE_OVERFLOW
                when -205 then Idna::Error::IDN2_TOO_BIG_DOMAIN
                when -206 then Idna::Error::IDN2_TOO_BIG_LABEL
                when -207 then Idna::Error::IDN2_INVALID_ALABEL
                when -208 then Idna::Error::IDN2_UALABEL_MISMATCH
                when -209 then Idna::Error::IDN2_INVALID_FLAGS
                when -300 then Idna::Error::IDN2_NOT_NFC
                when -301 then Idna::Error::IDN2_2HYPHEN
                when -302 then Idna::Error::IDN2_HYPHEN_STARTEND
                when -303 then Idna::Error::IDN2_LEADING_COMBINING
                when -304 then Idna::Error::IDN2_DISALLOWED
                when -305 then Idna::Error::IDN2_CONTEXTJ
                when -306 then Idna::Error::IDN2_CONTEXTJ_NO_RULE
                when -307 then Idna::Error::IDN2_CONTEXTO
                when -308 then Idna::Error::IDN2_CONTEXTO_NO_RULE
                when -309 then Idna::Error::IDN2_UNASSIGNED
                when -310 then Idna::Error::IDN2_BIDI
                when -311 then Idna::Error::IDN2_DOT_IN_LABEL
                when -312 then Idna::Error::IDN2_INVALID_TRANSITIONAL
                when -313 then Idna::Error::IDN2_INVALID_NONTRANSITIONAL
                when -314 then Idna::Error::IDN2_ALABEL_ROUNDTRIP_FAILED
                else           Idna::Error::UNKNOWN
                end
        raise klass.new message(int)
      end

      private

      def message(int)
        case int
        when    0 then 'OK'
        when -100 then 'Memory allocation error.'
        when -101 then 'Could not determine locale string encoding format.'
        when -102 then 'Could not transcode locale string to UTF-8.'
        when -200 then 'Unicode data encoding error.'
        when -201 then 'Error normalizing string.'
        when -202 then 'Punycode invalid input.'
        when -203 then 'Punycode output buffer too small.'
        when -204 then 'Punycode conversion would overflow.'
        when -205 then 'Domain name longer than 255 characters.'
        when -206 then 'Domain label longer than 63 characters.'
        when -207 then 'Input A-label is not valid.'
        when -208 then 'Input A-label and U-label does not match.'
        when -209 then 'Invalid combination of flags.'
        when -300 then 'String is not NFC.'
        when -301 then 'String has forbidden two hyphens.'
        when -302 then 'String has forbidden starting/ending hyphen.'
        when -303 then 'String has forbidden leading combining character.'
        when -304 then 'String has disallowed character.'
        when -305 then 'String has forbidden context-j character.'
        when -306 then 'String has context-j character with no rull.'
        when -307 then 'String has forbidden context-o character.'
        when -308 then 'String has context-o character with no rull.'
        when -309 then 'String has forbidden unassigned character.'
        when -310 then 'String has forbidden bi-directional properties.'
        when -311 then 'Label has forbidden dot (TR46).'
        when -312 then 'Label has character forbidden in transitional mode (TR46).'
        when -313 then 'Label has character forbidden in non-transitional mode (TR46).'
        when -314 then 'ALabel -> Ulabel -> ALabel result differs from input.'
        else           "Unrecognised Libidn2 error code '#{int}'."
        end
      end
    end
  end

  class Error::IDN2_OK                      < Idna::Error; end
  class Error::IDN2_MALLOC                  < Idna::Error; end
  class Error::IDN2_NO_CODESET              < Idna::Error; end
  class Error::IDN2_ICONV_FAIL              < Idna::Error; end
  class Error::IDN2_ENCODING_ERROR          < Idna::Error; end
  class Error::IDN2_NFC                     < Idna::Error; end
  class Error::IDN2_PUNYCODE_BAD_INPUT      < Idna::Error; end
  class Error::IDN2_PUNYCODE_BIG_OUTPUT     < Idna::Error; end
  class Error::IDN2_PUNYCODE_OVERFLOW       < Idna::Error; end
  class Error::IDN2_TOO_BIG_DOMAIN          < Idna::Error; end
  class Error::IDN2_TOO_BIG_LABEL           < Idna::Error; end
  class Error::IDN2_INVALID_ALABEL          < Idna::Error; end
  class Error::IDN2_UALABEL_MISMATCH        < Idna::Error; end
  class Error::IDN2_INVALID_FLAGS           < Idna::Error; end
  class Error::IDN2_NOT_NFC                 < Idna::Error; end
  class Error::IDN2_2HYPHEN                 < Idna::Error; end
  class Error::IDN2_HYPHEN_STARTEND         < Idna::Error; end
  class Error::IDN2_LEADING_COMBINING       < Idna::Error; end
  class Error::IDN2_DISALLOWED              < Idna::Error; end
  class Error::IDN2_CONTEXTJ                < Idna::Error; end
  class Error::IDN2_CONTEXTJ_NO_RULE        < Idna::Error; end
  class Error::IDN2_CONTEXTO                < Idna::Error; end
  class Error::IDN2_CONTEXTO_NO_RULE        < Idna::Error; end
  class Error::IDN2_UNASSIGNED              < Idna::Error; end
  class Error::IDN2_BIDI                    < Idna::Error; end
  class Error::IDN2_DOT_IN_LABEL            < Idna::Error; end
  class Error::IDN2_INVALID_TRANSITIONAL    < Idna::Error; end
  class Error::IDN2_INVALID_NONTRANSITIONAL < Idna::Error; end
  class Error::IDN2_ALABEL_ROUNDTRIP_FAILED < Idna::Error; end
  class Error::UNKNOWN                      < Idna::Error; end

  # V1 mappings, from:
  #
  #   https://gitlab.com/libidn/libidn2/-/blob/master/lib/idn2.h.in#L340
  #
  # ...with some adjustments to match observed behaviour - e.g. "too long"
  # should be "too big domain" or "too big input", but the above maps it to
  # "string has disallowed character", which seems to be incorrect (a bug).
  #
  Error::IDNA_STRINGPREP_ERROR       = Error::IDN2_ENCODING_ERROR
  Error::IDNA_PUNYCODE_ERROR         = Error::IDN2_PUNYCODE_BAD_INPUT
  Error::IDNA_CONTAINS_NON_LDH       = Error::IDN2_ENCODING_ERROR
  Error::IDNA_CONTAINS_LDH           = Error::IDNA_CONTAINS_NON_LDH
  Error::IDNA_CONTAINS_MINUS         = Error::IDN2_DISALLOWED
  Error::IDNA_INVALID_LENGTH         = Error::IDN2_TOO_BIG_LABEL
  Error::IDNA_NO_ACE_PREFIX          = Error::IDN2_ENCODING_ERROR
  Error::IDNA_ROUNDTRIP_VERIFY_ERROR = Error::IDN2_ENCODING_ERROR
  Error::IDNA_CONTAINS_ACE_PREFIX    = Error::IDN2_ENCODING_ERROR
  Error::IDNA_ICONV_ERROR            = Error::IDN2_ENCODING_ERROR
  Error::IDNA_MALLOC_ERROR           = Error::IDN2_MALLOC

  # Unmappable V1 error classes.
  #
  Error::IDNA_DLOPEN_ERROR           = Error::UNKNOWN

end
