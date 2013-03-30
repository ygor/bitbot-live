require "virtus"

module Bitbot
  module Live
    class Depth
      include Virtus::ValueObject

      attribute :price, Price
    end
  end
end
