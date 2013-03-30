require "bitbot/live/version"

module Bitbot
  module Live
  end
end

require "bitbot/live/price"
require "bitbot/live/volume"
require "bitbot/live/trade"
require "bitbot/live/depth"
require "bitbot/live/ticker"
require "bitbot/live/status"
require "bitbot/live/statuses"

require "bitbot/live/providers/mtgox"
require "bitbot/live/providers/mtgox/messages"
require "bitbot/live/providers/mtgox/message_parser"
require "bitbot/live/providers/mtgox/channels"
