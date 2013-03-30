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
            #
            # @return [PrivateMessage]
            #
            def self.build(data)
              type = data.fetch("private")
              klass_name = Inflecto.camelize(type) + "Message"
              PrivateMessages.const_get(klass_name).new(data.fetch(type)).generate
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
