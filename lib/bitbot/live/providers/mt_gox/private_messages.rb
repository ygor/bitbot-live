require "virtus"

module Bitbot
  module Live
    module Providers
      class MtGox
        module PrivateMessages
          # Message about orders placed or removed
          #
          class DepthMessage
            include Virtus::ValueObject

            attribute :price_int, BigDecimal
            attribute :currency, String

            # Converts MtGox depth message to actual Depth object
            #
            # @return [Depth]
            #
            def generate
              price = Price.new(
                value: price_int / 1_000_00,
                currency: currency
              )
              Depth.new(price: price)
            end
          end

          # Trades, as they occur
          #
          class TradeMessage
            include Virtus::ValueObject

            attribute :trade_type,     String
            attribute :amount_int,     String
            attribute :price_int,      String
            attribute :price_currency, String

            # Converts MtGox trade message to actual Trade object
            #
            # @return [Trade]
            #
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
          class TickerMessage
            include Virtus::ValueObject

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
            #
            class PriceWriter < Writer
              def self.value_column; :value; end
              def self.divider; 1_000_00; end
            end

            # Fetches volume from ticker message
            #
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

            # Converts MtGox ticker message to actual Ticker object
            #
            # @return [Ticker]
            #
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
          class ResultMessage
            include Virtus::ValueObject

            def generate
              OpenStruct.new
            end
          end
        end
      end
    end
  end
end
