require "spec_helper"

describe MtGox::Messages do
  describe ".get_class" do
    subject { described_class.get_class(operation) }

    context "when subscribe operation" do
      let(:operation) { "subscribe" }
      it { should be(MtGox::Messages::SubscribeMessage) }
    end

    context "when unsubscribe operation" do
      let(:operation) { "unsubscribe" }
      it { should be(MtGox::Messages::UnsubscribeMessage) }
    end

    context "when remark operation" do
      let(:operation) { "remark" }
      it { should be(MtGox::Messages::RemarkMessage) }
    end

    context "when private operation" do
      let(:operation) { "private" }
      it { should be(MtGox::Messages::PrivateMessage) }
    end

    context "when result operation" do
      let(:operation) { "result" }
      it { should be(MtGox::Messages::ResultMessage) }
    end
  end
end
