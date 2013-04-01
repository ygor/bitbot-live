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
      # @return [String]
      #
      # @example
      #  Trade.type #=> "trade"
      #
      def type
        @_type ||= name.split("::").last.downcase
      end
    end
  end
end
