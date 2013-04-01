require "json"

module Bitbot
  module Live
    module Providers
      class MtGox
        # Takes a raw message from mtgox and makes an actual message object
        #
        class MessageParser
          # Creates real object of a given raw message
          #
          # @param [String] raw_message
          #   a message in json format
          #
          # @return [Messages::Message]
          #
          def self.parse(raw_message)
            data = JSON.parse(raw_message)
            operation = data.fetch("op")
            Messages.get_class(operation).build(data)
          end
        end
      end
    end
  end
end
