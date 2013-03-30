require "bitbot/live"

class MyListener
  def message_received(message)
    if message.is_a?(Bitbot::Live::Ticker)
      show_ticker(message)
    elsif message.is_a?(Bitbot::Live::Status)
      puts message.inspect
    end
  end

  private

  def show_ticker(ticker)
    content = [
      "High: %5.5f" % ticker.high.value,
      "Low: %5.5f"  % ticker.low.value,
      "Buy: %5.5f"  % ticker.buy.value,
      "Sell: %5.5f" % ticker.sell.value
    ].join(" | ")

    puts content
  end
end

listener = MyListener.new
mtgox = Bitbot::Live::Providers::MtGox.new(listener)
EM.run { mtgox.start }
