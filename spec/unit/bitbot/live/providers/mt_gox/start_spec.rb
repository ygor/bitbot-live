require "spec_helper"

describe Providers::MtGox, "#start" do
  subject { worker.start }

  let(:worker)   { described_class.new(listener, client) }
  let(:client)   { mock(:web_socket_client) }
  let(:listener) { ListenerMock.new }
  let(:socket)   { WebSocketClientMock.new }

  before do
    client.stub(:connect) { socket }
  end

  it "connects with the websocket" do
    client.should_receive(:connect).with(Providers::MtGox::HOST) { socket }
    subject
  end

  it "sends connection established notification after connect" do
    subject
    socket.callback.call

    messages = listener.messages
    expect(messages.size).to eq(1)
    expect(messages.last.type).to eq("connected")
  end

  it "reconnects after disconnect" do
    subject

    client.should_receive(:connect).with(Providers::MtGox::HOST) { socket }
    socket.disconnect.call
  end

  it "sends notification about disconnect after disconnect" do
    subject
    socket.disconnect.call

    messages = listener.messages
    expect(messages.size).to eq(1)
    expect(messages.last.type).to eq("disconnected")
  end

  it "sends notification after error" do
    subject
    socket.errback.call("Ouch")

    messages = listener.messages
    expect(messages.size).to eq(1)
    expect(messages.last.type).to eq("error")
    expect(messages.last.body).to eq("Ouch")
  end

  it "sends message after receive" do
    subject

    message = stub
    Providers::MtGox::MessageParser.stub(:parse).with("RAW") { message }

    socket.stream.call("RAW")

    messages = listener.messages
    expect(messages.size).to eq(1)
    expect(messages.last).to eq(message)
  end
end
