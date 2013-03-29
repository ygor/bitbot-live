class WebSocketClientMock
  def initialize
    @cache = {}
  end

  def stream(&block)
    handle(__callee__, &block)
  end

  def callback(&block)
    handle(__callee__, &block)
  end

  def disconnect(&block)
    handle(__callee__, &block)
  end

  def errback(&block)
    handle(__callee__, &block)
  end

  private

  def handle(name, &block)
    block_given? ? @cache[name] = block : @cache[name]
  end
end
