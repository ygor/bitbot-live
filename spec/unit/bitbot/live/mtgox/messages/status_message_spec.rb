require "spec_helper"

describe MtGox::Messages::StatusMessage do
  it { should be_status }

  describe ".connected" do
    subject { described_class.connected }
    its(:type) { should eq("connected") }
  end

  describe ".disconnected" do
    subject { described_class.disconnected }
    its(:type) { should eq("disconnected") }
  end

  describe ".error" do
    subject { described_class.error("Oops") }
    its(:type) { should eq("error") }
    its(:body) { should eq("Oops") }
  end
end
