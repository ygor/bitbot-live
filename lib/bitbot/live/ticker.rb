require "virtus"

module Bitbot
  module Live
    # Market summary
    #
    class Ticker
      extend Listenable
      include Virtus::ValueObject

      attribute :high,       Price
      attribute :average,    Price
      attribute :low,        Price
      attribute :buy,        Price
      attribute :sell,       Price
      attribute :last_trade, Price
      attribute :volume,     Volume
    end
  end
end
