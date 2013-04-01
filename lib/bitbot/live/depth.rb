require "virtus"

module Bitbot
  module Live
    # Shows market depth
    #
    class Depth
      extend Listenable
      include Virtus::ValueObject

      attribute :price, Price
    end
  end
end
