require "spec_helper"

describe Providers::MtGox::PrivateMessages::DepthMessage, "#generate" do
  subject(:depth) { described_class.new(options).generate }

  let(:options) { {price_int: "312345", currency: "USD"} }

  it { should be_a(Depth) }

  context "price" do
    subject { depth.price }

    its(:value) { should be_decimal(3.12345) }
    its(:currency) { should eq("USD") }
  end
end
