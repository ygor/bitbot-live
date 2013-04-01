require "eventmachine"
require "em-websocket-client"

module Bitbot
  module Live
    module Providers
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
          process Statuses::CONNECTED
        end

        def disconnected
          process Statuses::DISCONNECTED

          start
        end

        def error(message)
          process Status.error(message)
        end

        def publish(raw_message)
          message = MessageParser.parse(raw_message)
          process message
        end

        # Sends message to the listener
        #
        # @param [Listenable] message
        #
        def process(message)
          method = :"#{message.class.type}_received"

          if @listener.respond_to?(method)
            @listener.public_send(method, message)
          end
        end
      end
    end
  end
end
