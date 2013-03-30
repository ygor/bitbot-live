require "bitbot/live"

class MyListener
  def message_received(message)
    if message.private? && message.type == :ticker
      show_ticker(message)
    elsif message.status?
      puts message.inspect
    end
  end

  private

  def show_ticker(ticker)
    content = [
      "High: %5.5f" % ticker.high.price,
      "Low: %5.5f"  % ticker.low.price,
      "Buy: %5.5f"  % ticker.buy.price,
      "Sell: %5.5f" % ticker.sell.price
    ].join(" | ")

    puts content
  end
end

listener = MyListener.new
mtgox = Bitbot::Live::MtGox.new(listener)
EM.run { mtgox.start }
