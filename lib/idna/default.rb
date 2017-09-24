module Idna
  module Default
    FFI_LIB = 'idn'.freeze

    class << self
      def ffi_lib
        FFI_LIB
      end
    end
  end
end
