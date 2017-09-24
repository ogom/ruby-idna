module Idna
  module Configure
    class << self
      def attributes
        @attributes ||= %i[ffi_lib]
      end

      def setup
        attributes.each do |attribute|
          if Idna::Default.respond_to?(attribute)
            instance_variable_set(:"@#{attribute}", Idna::Default.send(attribute))
          end
        end
      end

      def options
        Hash[
          Idna::Configure.attributes.map do |attribute|
            [attribute, instance_variable_get(:"@#{attribute}")]
          end
        ]
      end

      attr_accessor *Idna::Configure.attributes
    end
  end
end
