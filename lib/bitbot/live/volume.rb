require "virtus"

module Bitbot
  module Live
    # Value object of a market volume. Volume has a size and a currency.
    # e.g 34532355.3242 USD
    #
    class Volume
      include Virtus::ValueObject

      attribute :size, BigDecimal
      attribute :currency, String
    end
  end
end
