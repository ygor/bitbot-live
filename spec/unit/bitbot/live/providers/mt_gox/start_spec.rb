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

    expect(listener.statuses).to eq([Statuses::CONNECTED])
  end

  it "reconnects after disconnect" do
    subject

    client.should_receive(:connect).with(Providers::MtGox::HOST) { socket }
    socket.disconnect.call
  end

  it "sends notification about disconnect after disconnect" do
    subject
    socket.disconnect.call

    expect(listener.statuses).to eq([Statuses::DISCONNECTED])
  end

  it "sends notification after error" do
    subject
    socket.errback.call("Ouch")

    statuses = listener.statuses
    expect(statuses.size).to eq(1)
    expect(statuses.last.type).to eq("error")
    expect(statuses.last.body).to eq("Ouch")
  end

  it "sends message after receive" do
    subject

    trade = Trade.new
    Providers::MtGox::MessageParser.stub(:parse).with("RAW") { trade }

    socket.stream.call("RAW")

    expect(listener.trades).to eq([trade])
  end
end
