require "inflecto"
require "virtus"

module Bitbot
  module Live
    module Providers
      class MtGox
        module Messages
          # Finds correct message class using given operation
          #
          # @param [String] operation
          #
          # @return [Class] A subclass of Message
          #
          def self.get_class(operation)
            klass_name = Inflecto.camelize(operation) + "Message"
            const_get(klass_name)
          end

          # Base class for messages
          #
          # @abstract
          #
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
              PrivateMessages.get_class(type).new(data.fetch(type)).generate
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
