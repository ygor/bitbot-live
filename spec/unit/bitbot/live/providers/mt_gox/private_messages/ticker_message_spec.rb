require "spec_helper"

describe Providers::MtGox::PrivateMessages::TickerMessage do
  subject { described_class.new(options) }

  it_behaves_like "a private message"

  let(:options) {
    {avg: price, buy: price, high: price, low: price, sell: price, last_local: price, vol: volume}
  }
  let(:price) { {"value_int" => "100000", "currency" => "USD"} }
  let(:volume) { {"value_int" => "100000000", "currency" => "BTC"} }
end
