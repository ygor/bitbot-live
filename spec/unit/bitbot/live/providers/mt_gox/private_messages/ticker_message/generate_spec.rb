require "spec_helper"

describe Providers::MtGox::PrivateMessages::TickerMessage, "#generate" do
  subject(:ticker) { described_class.new(options).generate }

  let(:options) {
    {avg: price, buy: price, high: price, low: price, sell: price, last_local: price, vol: volume}
  }
  let(:price) { {"value_int" => "312345", "currency" => "USD"} }
  let(:volume) { {"value_int" => "412345678", "currency" => "BTC"} }

  it { should be_a(Ticker) }

  context "high" do
    subject { ticker.high }

    its(:value) { should be_decimal(3.12345) }
    its(:currency) { should eq("USD") }
  end

  context "average" do
    subject { ticker.average }

    its(:value) { should be_decimal(3.12345) }
    its(:currency) { should eq("USD") }
  end

  context "low" do
    subject { ticker.low }

    its(:value) { should be_decimal(3.12345) }
    its(:currency) { should eq("USD") }
  end

  context "buy" do
    subject { ticker.buy }

    its(:value) { should be_decimal(3.12345) }
    its(:currency) { should eq("USD") }
  end

  context "sell" do
    subject { ticker.sell }

    its(:value) { should be_decimal(3.12345) }
    its(:currency) { should eq("USD") }
  end

  context "last_trade" do
    subject { ticker.last_trade }

    its(:value) { should be_decimal(3.12345) }
    its(:currency) { should eq("USD") }
  end

  context "volume" do
    subject { ticker.volume }

    its(:size) { should be_decimal(4.12345678) }
    its(:currency) { should eq("BTC") }
  end
end
