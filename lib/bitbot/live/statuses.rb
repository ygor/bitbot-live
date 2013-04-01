module Bitbot
  module Live
    # Common statuses used by the providers
    #
    module Statuses
      CONNECTED    = Status.new(type: "connected")
      DISCONNECTED = Status.new(type: "disconnected")
    end
  end
end
