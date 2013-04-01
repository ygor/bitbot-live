require "virtus"

module Bitbot
  module Live
    class Trade
      extend Listenable
      include Virtus::ValueObject

      attribute :bid,      Boolean
      attribute :amount,   BigDecimal
      attribute :price,    Price

      # Returns true if trade is not a bid trade
      #
      # @return [Boolean]
      def ask?
        !bid?
      end
    end
  end
end
