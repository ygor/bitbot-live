class ListenerMock
  attr_reader :trades, :statuses

  def initialize
    @trades = []
    @statuses = []
  end

  def trade_received(trade)
    @trades << trade
  end

  def status_received(status)
    @statuses << status
  end
end
