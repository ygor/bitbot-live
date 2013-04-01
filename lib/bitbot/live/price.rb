require "virtus"

module Bitbot
  module Live
    # Price value object. Every price has a value and a currency.
    # e.g 5.6 USD
    #
    class Price
      include Virtus::ValueObject

      attribute :value, BigDecimal
      attribute :currency, String
    end
  end
end
