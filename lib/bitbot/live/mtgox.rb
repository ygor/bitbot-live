require "json"
require "eventmachine"
require "em-websocket-client"

module Bitbot
  module Live
    class MtGox
      HOST = "ws://websocket.mtgox.com/mtgox"

      def initialize(listener)
        @listener = listener
      end

      def start
        socket = EM::WebSocketClient.connect(HOST)
        socket.stream     { |raw_message| publish raw_message }
        socket.callback   { process :connected }
        socket.disconnect { process :disconnected }
        socket.errback    { |error| process :error_received, error }
      end

      private

      def process(event, *args)
        return unless @listener.respond_to?(event)
        @listener.public_send(event, *args)
      end

      def publish(raw_message)
        message = MessageParser.parse(raw_message)
        process :trade_message_received, message
      end
    end
  end
end
