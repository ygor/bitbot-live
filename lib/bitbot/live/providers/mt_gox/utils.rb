module Bitbot
  module Live
    module Providers
      class MtGox
        # Utility methods that MtGox code needs
        #
        module Utils
          # @param [String] value
          # @param [String] currency
          #
          # @return [Hash] compatible with Price class
          #
          def self.parse_price(value, currency)
            {value: value / 1_000_00, currency: currency}
          end

          # @param [BigDecimal] size
          # @param [String] currency
          #
          # @return [Hash] compatible with Volume class
          #
          def self.parse_volume(size, currency)
            {size: size / 1_0000_0000, currency: currency}
          end
        end
      end
    end
  end
end
