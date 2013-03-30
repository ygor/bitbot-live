require "spec_helper"

describe Providers::MtGox::PrivateMessages::TradeMessage, "#generate" do
  subject(:trade) { described_class.new(options).generate }

  let(:options) {
    {
      price_int: "312345", price_currency: "USD",
      amount_int: "412345678", trade_type: "bid"
    }
  }

  it { should be_a(Trade) }
  it { should be_bid }
  its(:amount) { should be_decimal(4.12345678) }

  context "price" do
    subject { trade.price }

    its(:value) { should be_decimal(3.12345) }
    its(:currency) { should eq("USD") }
  end
end
