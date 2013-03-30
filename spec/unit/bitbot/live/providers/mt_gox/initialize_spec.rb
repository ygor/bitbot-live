require "spec_helper"

describe Providers::MtGox, "#initialize" do
  let(:listener) { ListenerMock.new }

  context "when client not given" do
    subject { described_class.new(listener) }

    it { should be_a(described_class) }
  end

  context "when client given" do
    subject { described_class.new(client, client) }

    let(:client) { mock(:web_socket_client) }

    it { should be_a(described_class) }
  end
end
