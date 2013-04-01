require "virtus"

module Bitbot
  module Live
    class Depth
      extend Listenable
      include Virtus::ValueObject

      attribute :price, Price
    end
  end
end
