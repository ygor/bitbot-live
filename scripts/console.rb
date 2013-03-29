require "bitbot/live"

class MyListener
  def trade_message_received(message)
    puts message.inspect
  end

  def error_received(message)
    puts "Got an error: #{message}"
  end

  def connected
    puts "Connected"
  end

  def disconnected
    puts "Disconnect"
    EM.stop_event_loop
  end
end

listener = MyListener.new
mtgox = Bitbot::Live::MtGox.new(listener)
EM.run { mtgox.start }
