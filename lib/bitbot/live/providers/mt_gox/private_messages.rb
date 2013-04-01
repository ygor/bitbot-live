require "inflecto"
require "virtus"

module Bitbot
  module Live
    module Providers
      class MtGox
        module PrivateMessages
          # @param [String] type
          #
          # @return [Class]
          #   A class of one of the PrivateMessages classes
          #
          def self.get_class(type)
            klass_name = Inflecto.camelize(type) + "Message"
            const_get(klass_name)
          end

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
              price = Utils.parse_price(price_int, currency)
              Depth.new(price: price)
            end
          end

          # Trades, as they occur
          #
          class TradeMessage
            include Virtus::ValueObject

            attribute :trade_type,     String
            attribute :amount_int,     BigDecimal
            attribute :price_int,      BigDecimal
            attribute :price_currency, String

            # Converts MtGox trade message to actual Trade object
            #
            # @return [Trade]
            #
            def generate
              Trade.new(
                bid: trade_type == "bid",
                amount: amount_int / 1_0000_0000,
                price: Utils.parse_price(price_int, price_currency)
              )
            end
          end

          # Information about the market
          #
          class TickerMessage
            include Virtus::ValueObject

            # Coerces objects with value and currency
            #
            class ValueWriter < Virtus::Attribute::Writer::Coercible
              def self.parse(type, hash)
                value, currency = hash.values_at("value_int", "currency")
                Utils.public_send(:"parse_#{type}", BigDecimal(value), currency)
              end
            end

            # Fetches price from ticker message
            #
            class PriceWriter < ValueWriter
              def coerce(hash)
                self.class.parse(:price, hash)
              end
            end

            # Fetches volume from ticker message
            #
            class VolumeWriter < ValueWriter
              def coerce(hash)
                self.class.parse(:volume, hash)
              end
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
