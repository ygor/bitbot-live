require "eventmachine"
require "em-websocket-client"

module Bitbot
  module Live
    class MtGox
      HOST = "https://websocket.mtgox.com:80/mtgox?Currency=USD"

      def initialize(listener, client = EM::WebSocketClient)
        @listener = listener
        @client   = client
      end

      def start
        @socket = @client.connect(HOST)
        @socket.stream     { |raw_message| publish raw_message }
        @socket.callback   { connected }
        @socket.disconnect { disconnected }
        @socket.errback    { |raw_message| error(raw_message) }
      end

      private

      def connected
        message = Messages::StatusMessage.connected
        process message
      end

      def disconnected
        message = Messages::StatusMessage.disconnected
        process message

        start
      end

      def error(message)
        message = Messages::StatusMessage.error(message)
        process message
      end

      def publish(raw_message)
        message = MessageParser.parse(raw_message)
        process message
      end

      def process(message)
        @listener.message_received(message)
      end
    end
  end
end
