require "inflecto"
require "virtus"

module Bitbot
  module Live
    module Providers
      class MtGox
        module Messages
          # @param [String] operation
          def self.get_class(operation)
            klass_name = Inflecto.camelize(operation) + "Message"
            const_get(klass_name)
          end

          # @abstract
          class Message
            include Virtus::ValueObject
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
            def self.build(*)
              new
            end

            attribute :todo, String, default: "TODO"
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
              PrivateMessages.const_get(klass_name).new(data.fetch(type)).generate
            end

            def generate
              self
            end
          end

          module PrivateMessages
            # Message about orders placed or removed
            #
            class DepthMessage < PrivateMessage
              attribute :price_int, String

              def generate
                Depth.new(price: BigDecimal(price_int) / 1_000_00)
              end
            end

            # Trades, as they occur
            #
            class TradeMessage < PrivateMessage
              attribute :trade_type,     String
              attribute :amount_int,     String
              attribute :price_int,      String
              attribute :price_currency, String

              def generate
                Trade.new(
                  bid: trade_type == "bid",
                  amount: BigDecimal(amount_int) / 1_0000_0000,
                  price: Price.new(
                    value: BigDecimal(price_int) / 1_000_00,
                    currency: price_currency
                  )
                )
              end
            end

            # Information about the market
            #
            class TickerMessage < PrivateMessage
              class ValueWrapper
                include Virtus
                attribute :value_int, BigDecimal
                attribute :currency, String
              end

              class Writer < Virtus::Attribute::Writer::Coercible
                def coerce(hash)
                  value = ValueWrapper.new(hash)
                  util = self.class

                  {
                    util.value_column => value.value_int / util.divider,
                    currency: value.currency
                  }
                end
              end

              # Fetches price from ticker message
              class PriceWriter < Writer
                def self.value_column; :value; end
                def self.divider; 1_000_00; end
              end

              # Fetches volume from ticker message
              class VolumeWriter < Writer
                def self.value_column; :size; end
                def self.divider; 1_0000_0000; end
              end

              attribute :avg,        Price,  writer_class: PriceWriter
              attribute :buy,        Price,  writer_class: PriceWriter
              attribute :high,       Price,  writer_class: PriceWriter
              attribute :low,        Price,  writer_class: PriceWriter
              attribute :sell,       Price,  writer_class: PriceWriter
              attribute :last_local, Price,  writer_class: PriceWriter
              attribute :vol,        Volume, writer_class: VolumeWriter

              def generate
                Ticker.new(
                  high:       high,
                  average:    avg,
                  low:        low,
                  buy:        buy,
                  sell:       sell,
                  last_trade: last_local,
                  volume:     vol
                )
              end
            end

            # The result of a websocket-encapsulated version 1 HTTP API request
            #
            class ResultMessage < PrivateMessage
              def generate
                OpenStruct.new
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
end
