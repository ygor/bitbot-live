class ListenerMock
  attr_reader :messages

  def initialize
    @messages = []
  end

  def message_received(message)
    @messages << message
  end
end
