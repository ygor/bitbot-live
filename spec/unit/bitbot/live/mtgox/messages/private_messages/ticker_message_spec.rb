require "spec_helper"

describe MtGox::Messages::PrivateMessages::TickerMessage do
  it_behaves_like "a private message"

  subject { described_class.new(options) }
  let(:options) { {} }
  let(:price)   { {value_int: 100000, currency: "USD"} }
  let(:volume)  { {value_int: 1_0000_0000, currency: "BTC"} }

  its(:type) { should eq(:ticker) }

  [:buy, :high, :low, :sell].each do |target|
    describe "##{target}" do
      before { options[target] = price }
      its(target) { should be_a(described_class::PriceWrapper) }
    end
  end

  describe "#average" do
    before { options[:avg] = price }
    its(:average) { should be_a(described_class::PriceWrapper) }
  end

  describe "#last_trade" do
    before { options[:last_local] = price }
    its(:last_trade) { should be_a(described_class::PriceWrapper) }
  end

  describe "#volume" do
    before { options[:vol] = volume }
    its(:volume) { should be_a(described_class::Volume) }
  end
end
