require "spec_helper"

describe Providers::MtGox::PrivateMessages, ".get_class" do
  subject { described_class.get_class(type) }

  context "when type is depth" do
    let(:type) { "depth" }
    it { should be(Providers::MtGox::PrivateMessages::DepthMessage) }
  end

  context "when type is trade" do
    let(:type) { "trade" }
    it { should be(Providers::MtGox::PrivateMessages::TradeMessage) }
  end

  context "when type is ticker" do
    let(:type) { "ticker" }
    it { should be(Providers::MtGox::PrivateMessages::TickerMessage) }
  end

  context "when type is result" do
    let(:type) { "result" }
    it { should be(Providers::MtGox::PrivateMessages::ResultMessage) }
  end
end
