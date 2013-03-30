require "spec_helper"

describe Statuses do
  describe "::CONNECTED" do
    subject { described_class::CONNECTED }
    its(:type) { should eq("connected") }
  end

  describe "::DISCONNECTED" do
    subject { described_class::DISCONNECTED }
    its(:type) { should eq("disconnected") }
  end
end
