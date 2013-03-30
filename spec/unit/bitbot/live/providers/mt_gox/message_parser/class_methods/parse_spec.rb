require "spec_helper"

describe Providers::MtGox::MessageParser, ".parse" do
  subject { described_class.parse(data) }

  let(:operation) { "operation" }
  let(:data) { JSON.dump({"op" => operation}) }
  let(:operation_class) {
    Class.new(Struct.new(:data)) do
      def self.build(data)
        new(data)
      end
    end
  }

  before do
    Providers::MtGox::Messages.stub(:get_class).with(operation) { operation_class }
  end

  it { should be_a(operation_class) }
  its(:data) { should eq("op" => operation) }
end
