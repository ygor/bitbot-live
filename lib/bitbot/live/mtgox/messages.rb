require "inflecto"
require "virtus"

module Bitbot
  module Live
    class MtGox
      module Messages
        # @param [String] operation
        def self.get_class(operation)
          klass_name = Inflecto.camelize(operation) + "Message"
          const_get(klass_name)
        end

        # @abstract
        class Message
          # @param [Hash] data
          def self.build(data)
            raise NotImplementedError
          end
        end

        # Notification that the user is subscribed to a channel
        #
        class SubscribeMessage < Message
        end

        # Notification that messages will not arrive over a given channel
        #
        class UnsubscribeMessage < Message
        end

        # A server message, usually a warning
        #
        class RemarkMessage < Message
        end

        # Depth, trade and ticker messages
        #
        # @abstract
        #
        class PrivateMessage < Message
          include Virtus

          # @param [Hash] data
          def self.build(data)
            type = data.fetch("private")
            klass_name = Inflecto.camelize(type) + "Message"
            PrivateMessages.const_get(klass_name).new(data.fetch(type))
          end
        end

        module PrivateMessages
          # Message about orders placed or removed
          #
          class DepthMessage < PrivateMessage
            attribute :price, BigDecimal
          end

          # Trades, as they occur
          #
          class TradeMessage < PrivateMessage
          end

          # Information about the market
          #
          class TickerMessage < PrivateMessage
          end

          # The result of a websocket-encapsulated version 1 HTTP API request
          #
          class ResultMessage < PrivateMessage
          end
        end

        # The response for op:call operations
        #
        class ResultMessage < Message
        end
      end
    end
  end
end
