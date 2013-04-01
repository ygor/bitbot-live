require "eventmachine"
require "em-websocket-client"

module Bitbot
  module Live
    module Providers
      # MtGox WebSocket provider
      #
      # @see https://en.bitcoin.it/wiki/MtGox/API/Streaming
      #
      class MtGox
        HOST = "https://websocket.mtgox.com:80/mtgox?Currency=USD"

        # Initializes MtGox provider
        #
        # @param [Object] listener
        #   Messages and status nofifications are sent to it. To receive
        #   trade messages, it should implement #trade_received method.
        #
        # @client [#connect] web socket client
        #
        # @return [undefined]
        #
        # @api public
        #
        def initialize(listener, client = EM::WebSocketClient)
          @listener = listener
          @client   = client
        end

        # Connects with the websocket to receive messages
        #
        # @return [undefined]
        #
        # @api public
        #
        def start
          @socket = @client.connect(HOST)
          @socket.stream     { |raw_message| publish raw_message }
          @socket.callback   { connected }
          @socket.disconnect { disconnected }
          @socket.errback    { |raw_message| error(raw_message) }
        end

        private

        # Sends connected status notification to the listener
        #
        # @return [undefined]
        #
        # @api private
        #
        def connected
          process Statuses::CONNECTED
        end

        # Sends disconnected status notification to the listener
        #
        # @return [undefined]
        #
        # @api private
        #
        def disconnected
          process Statuses::DISCONNECTED

          start
        end

        # Sends error message to the listener
        #
        # @param [String] raw_message
        #   JSON encoded message
        #
        # @return [undefined]
        #
        # @api private
        #
        def error(raw_message)
          process Status.error(raw_message)
        end

        # Parses raw message and sends it to the listener
        #
        # @param [String] raw_message
        #   JSON encoded message
        #
        # @return [undefined]
        #
        # @api private
        #
        def publish(raw_message)
          message = MessageParser.parse(raw_message)
          process message
        end

        # Sends message to the listener if the listener responds to given type
        #
        # @param [Listenable] message
        #
        # @return [undefined]
        #
        # @api private
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
