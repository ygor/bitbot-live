require "bitbot/live"

class MyListener
  def trade_received(trade)
    price  = "%5.5f" % trade.price.value
    amount = "%5.8f" % trade.amount
    currency = trade.price.currency

    if trade.bid?
      puts "BUY:  \t #{price} #{currency} x #{amount}"
    else
      puts "SELL: \t #{price} #{currency} x #{amount}"
    end
  end

  def status_notification_received(status)
    puts status.inspect
  end
end

listener = MyListener.new
mtgox = Bitbot::Live::Providers::MtGox.new(listener)
EM.run { mtgox.start }
