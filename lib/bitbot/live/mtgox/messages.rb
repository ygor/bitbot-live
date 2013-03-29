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
          include Virtus
        end

        # Notification that the user is subscribed to a channel
        #
        class SubscribeMessage < Message
        end

        # Notification that messages will not arrive over a given channel
        #
        class UnsubscribeMessage < Message
        end

        # A server notification, answer to a subscription, server warning, etc
        #
        class RemarkMessage < Message
          def self.build(data)
            puts data.inspect
            new
          end
        end

        # Depth, trade and ticker messages
        #
        # @abstract
        #
        class PrivateMessage < Message
          # @param [Hash] data
          # @return [PrivateMessage]
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

            def type
              :depth
            end
          end

          # Trades, as they occur
          #
          class TradeMessage < PrivateMessage
            attribute :trade_type,     String
            attribute :amount_int,     Integer, reader: :private
            attribute :price_int,      Integer, reader: :private
            attribute :price_currency, String,  reader: :private

            def bid?
              trade_type == "bid"
            end

            def ask?
              !bid?
            end

            def amount
              amount_int.to_f / 1_0000_0000
            end

            def price
              price_int.to_f / 1_000_00
            end

            def currency
              price_currency
            end

            def type
              :trade
            end
          end

          # Information about the market
          #
          class TickerMessage < PrivateMessage
            def type
              :ticker
            end
          end

          # The result of a websocket-encapsulated version 1 HTTP API request
          #
          class ResultMessage < PrivateMessage
            def type
              :result
            end
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
