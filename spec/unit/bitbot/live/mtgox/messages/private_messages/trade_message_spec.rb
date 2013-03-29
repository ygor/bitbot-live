require "spec_helper"

describe MtGox::Messages::PrivateMessages::TradeMessage do
  it_behaves_like "a private message"

  subject { described_class.new(options) }
  let(:options) { {} }

  its(:type) { should eq(:trade) }

  describe "#bid?" do
    context "when trade_type is bid" do
      before { options[:trade_type] = "bid" }
      it { should be_bid }
    end

    context "when trade_type is ask" do
      before { options[:trade_type] = "ask" }
      it { should_not be_bid }
    end
  end

  describe "#ask?" do
    context "when trade_type is ask" do
      before { options[:trade_type] = "ask" }
      it { should be_ask }
    end

    context "when trade_type is bid" do
      before { options[:trade_type] = "bid" }
      it { should_not be_ask }
    end
  end

  describe "#amount" do
    before { options[:amount_int] = 312345678 }
    its(:amount) { should eq(3.12345678) }
  end

  describe "#price" do
    before { options[:price_int] = 512345 }
    its(:price) { should eq(5.12345) }
  end

  describe "#currency" do
    before { options[:price_currency] = "EUR" }
    its(:currency) { should eq("EUR") }
  end
end
