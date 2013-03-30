require "bitbot/live"

class MyListener
  def message_received(message)
    if message.private? && message.type == :trade
      show_trade(message)
    elsif message.status?
      puts message.inspect
    end
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

listener = MyListener.new
mtgox = Bitbot::Live::MtGox.new(listener)
EM.run { mtgox.start }
