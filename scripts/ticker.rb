require "bitbot/live"

class MyListener
  def ticker_received(ticker)
    content = [
      "High: %5.5f" % ticker.high.value,
      "Low: %5.5f"  % ticker.low.value,
      "Buy: %5.5f"  % ticker.buy.value,
      "Sell: %5.5f" % ticker.sell.value
    ].join(" | ")

    puts content
  end

  def status_notification_received(status)
    puts status.inspect
  end
end

listener = MyListener.new
mtgox = Bitbot::Live::Providers::MtGox.new(listener)
EM.run { mtgox.start }
