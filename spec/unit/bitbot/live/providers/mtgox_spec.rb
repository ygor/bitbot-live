require "spec_helper"

describe Providers::MtGox do
  subject(:worker) { described_class.new(listener, client) }

  let(:client)   { mock(:web_socket_client) }
  let(:listener) { ListenerMock.new }
  let(:socket)   { WebSocketClientMock.new }

  before do
    client.stub(:connect) { socket }
  end

  it "connects with the websocket" do
    client.should_receive(:connect).with(Providers::MtGox::HOST) { socket }
    subject.start
  end

  it "sends connection established notification after connect" do
    subject.start
    socket.callback.call

    messages = listener.messages
    expect(messages.size).to eq(1)
    expect(messages.last.type).to eq("connected")
  end

  it "reconnects after disconnect" do
    subject.start

    client.should_receive(:connect).with(Providers::MtGox::HOST) { socket }
    socket.disconnect.call
  end

  it "sends notification about disconnect after disconnect" do
    subject.start
    socket.disconnect.call

    messages = listener.messages
    expect(messages.size).to eq(1)
    expect(messages.last.type).to eq("disconnected")
  end

  it "sends notification after error" do
    subject.start
    socket.errback.call("Ouch")

    messages = listener.messages
    expect(messages.size).to eq(1)
    expect(messages.last.type).to eq("error")
    expect(messages.last.body).to eq("Ouch")
  end

  it "sends message after receive" do
    subject.start

    message = stub
    Providers::MtGox::MessageParser.stub(:parse).with("RAW") { message }

    socket.stream.call("RAW")

    messages = listener.messages
    expect(messages.size).to eq(1)
    expect(messages.last).to eq(message)
  end
end
