module Bitbot
  module Live
    # Classes than can be sent to user listeners use this class
    #
    # @example
    #   class Trade
    #     extend Listenable
    #   end
    #
    module Listenable
      # Returns type of a class
      #
      # @example
      #  Trade.type #=> "trade"
      #
      # @return [String]
      #
      # @api public
      #
      def type
        @_type ||= name.split("::").last.downcase
      end
    end
  end
end
