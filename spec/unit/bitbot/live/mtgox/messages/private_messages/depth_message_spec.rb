require "spec_helper"

describe MtGox::Messages::PrivateMessages::DepthMessage do
  it_behaves_like "a private message"

  subject { described_class.new(options) }
  let(:options) { {} }

  its(:type) { should eq(:depth) }
end
