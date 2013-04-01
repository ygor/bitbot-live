require "virtus"

module Bitbot
  module Live
    # Object to notify listeners about connection status
    #
    class Status
      extend Listenable
      include Virtus::ValueObject

      def self.error(body)
        new(type: "error", body: body)
      end

      attribute :type, String
      attribute :body, String
    end
  end
end
