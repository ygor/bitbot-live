require "spec_helper"

describe Providers::MtGox::Messages::PrivateMessage, ".build" do
  subject { described_class.build(data) }

  let(:data) {
    {"private" => "trade", "trade" => "foo"}
  }

  let(:private_message_class) {
    Class.new(Struct.new(:data)) do
      def generate
        data
      end
    end
  }

  before do
    Providers::MtGox::PrivateMessages.stub(:get_class).
      with("trade").
      and_return(private_message_class)
  end

  it { should eq("foo") }
end
