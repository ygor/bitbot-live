module Bitbot
  module Live
    module Providers
      class MtGox
        # Utility methods that MtGox code needs
        #
        module Utils
          # Creates Price compatible hash object
          #
          # @param [String] value
          #
          # @param [String] currency
          #
          # @return [Hash] compatible with Price class
          #
          # @api private
          #
          def self.parse_price(value, currency)
            {value: value / 1_000_00, currency: currency}
          end

          # Creates Volume compatible hash object
          #
          # @param [BigDecimal] size
          #
          # @param [String] currency
          #
          # @return [Hash] compatible with Volume class
          #
          # @api private
          #
          def self.parse_volume(size, currency)
            {size: size / 1_0000_0000, currency: currency}
          end
        end
      end
    end
  end
end
