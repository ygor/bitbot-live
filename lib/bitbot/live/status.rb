require "virtus"

module Bitbot
  module Live
    # Object to notify listeners about connection status
    #
    class Status
      extend Listenable
      include Virtus::ValueObject

      # Creates an error status
      #
      # @return [Status]
      #   Error status instance with given body
      #
      # @api private
      #
      def self.error(body)
        new(type: "error", body: body)
      end

      attribute :type, String
      attribute :body, String
    end
  end
end
