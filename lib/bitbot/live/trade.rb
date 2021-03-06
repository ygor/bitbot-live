require "virtus"

module Bitbot
  module Live
    # Shows a buy or a sell that happened in a market
    #
    class Trade
      extend Listenable
      include Virtus::ValueObject

      attribute :bid,      Boolean
      attribute :amount,   BigDecimal
      attribute :price,    Price

      # Returns true if trade is not a bid trade
      #
      # @example
      #  Trade.new(bid: true).ask? #=> false
      #
      # @return [Boolean]
      #
      # @api public
      #
      def ask?
        !bid?
      end
    end
  end
end
