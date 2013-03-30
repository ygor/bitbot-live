require "virtus"

module Bitbot
  module Live
    class Price
      include Virtus::ValueObject

      attribute :value, BigDecimal
      attribute :currency, String
    end
  end
end
