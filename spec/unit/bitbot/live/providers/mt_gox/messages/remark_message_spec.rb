require "spec_helper"

describe Providers::MtGox::Messages::RemarkMessage do
  describe ".build" do
    it "returns new object" do
      data = stub
      described_class.build(data).should eq(described_class.new)
    end
  end
end
