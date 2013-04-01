require "bitbot/live/version"

module Bitbot
  module Live
  end
end

require "bitbot/live/listenable"
require "bitbot/live/price"
require "bitbot/live/volume"
require "bitbot/live/trade"
require "bitbot/live/depth"
require "bitbot/live/ticker"
require "bitbot/live/status"
require "bitbot/live/statuses"

require "bitbot/live/providers/mt_gox"
require "bitbot/live/providers/mt_gox/messages"
require "bitbot/live/providers/mt_gox/private_messages"
require "bitbot/live/providers/mt_gox/message_parser"
require "bitbot/live/providers/mt_gox/channels"
