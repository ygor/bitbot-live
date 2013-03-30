require "bitbot/live"

class MyListener
  def message_received(message)
    if message.is_a?(Bitbot::Live::Trade)
      show_trade(message)
    elsif message.is_a?(Bitbot::Live::Status)
      puts message.inspect
    end
  end

  private

  def show_trade(trade)
    price  = "%5.5f" % trade.price.value
    amount = "%5.8f" % trade.amount
    currency = trade.price.currency

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
