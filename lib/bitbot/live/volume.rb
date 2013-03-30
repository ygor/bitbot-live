require "virtus"

module Bitbot
  module Live
    class Volume
      include Virtus::ValueObject

      attribute :size, BigDecimal
      attribute :currency, String
    end
  end
end
