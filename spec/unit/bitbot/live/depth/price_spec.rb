require "spec_helper"

describe Depth, "#price" do
  subject { described_class.new(options).price }
  let(:options) { {} }

  it { should be_nil }

  context "when with price" do
    before { options[:price] = Price.new }
    it { should be_a(Price) }
  end
end
