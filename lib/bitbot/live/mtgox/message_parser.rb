require "json"

module Bitbot
  module Live
    class MtGox
      # Takes a raw message from mtgox and makes an actual message object
      #
      class MessageParser
        # @param [String] raw_message - a message in json format
        # @return [Messages::Message]
        def self.parse(raw_message)
          data = JSON.parse(raw_message)
          operation = data.fetch("op")
          Messages.get_class(operation).build(data)
        end
      end
    end
  end
end
