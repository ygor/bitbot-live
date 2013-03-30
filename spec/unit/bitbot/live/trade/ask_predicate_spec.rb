require "spec_helper"

describe Trade, "ask?" do
  subject { trade.ask? }

  context "when trade is not a bid" do
    let(:trade) { described_class.new(bid: false) }
    it { should be(true) }
  end

  context "when trade is a bid" do
    let(:trade) { described_class.new(bid: true) }
    it { should be(false) }
  end
end
