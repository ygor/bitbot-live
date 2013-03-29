require "bitbot/live"

class MyListener
  def message_received(message)
    return unless message.is_a?(Bitbot::Live::MtGox::Messages::PrivateMessage)
    if message.type == :trade
      show_trade(message)
    end
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

  private

  def show_trade(trade)
    price  = "%5.5f" % trade.price
    amount = "%5.8f" % trade.amount
    currency = trade.currency

    if trade.bid?
      puts "BUY:  \t #{price} #{currency} x #{amount}"
    else
      puts "SELL: \t #{price} #{currency} x #{amount}"
    end
  end
end

begin
  listener = MyListener.new
  mtgox = Bitbot::Live::MtGox.new(listener)
  #mtgox.subscribe_to :trades
  EM.run { mtgox.start }
rescue => e
  puts e.inspect
  puts e.backtrace.join("\n")
end
