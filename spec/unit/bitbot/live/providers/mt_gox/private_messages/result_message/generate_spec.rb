require "spec_helper"

describe Providers::MtGox::PrivateMessages::ResultMessage, "#generate" do
  subject { described_class.new(options).generate }

  let(:options) { {} }

  it { should be_a(OpenStruct) }
end
