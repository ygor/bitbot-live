require "eventmachine"
require "em-websocket-client"

module Bitbot
  module Live
    class MtGox
      HOST = "https://websocket.mtgox.com:80/mtgox?Currency=USD"

      def initialize(listener)
        @listener = listener
      end

      def start
        @socket = EM::WebSocketClient.connect(HOST)
        @socket.stream     { |raw_message| publish raw_message }
        @socket.callback   { connected }
        @socket.disconnect { process :disconnected }
        @socket.errback    { |error| process :error_received, error }
      end

      def subscribe_to(target)
      end

      private

      def connected
        process :connected

        #@socket.send_msg JSON.dump({
        #  op: "subscribe",
        #  channel: Channels::TRADES
        #})
      end

      def process(event, *args)
        return unless @listener.respond_to?(event)
        @listener.public_send(event, *args)
      end

      def publish(raw_message)
        message = MessageParser.parse(raw_message)
        process :message_received, message
      end
    end
  end
end
