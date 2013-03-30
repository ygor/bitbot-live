require "spec_helper"

describe Providers::MtGox::MessageParser do
  describe ".parse" do
    let(:operation) { "operation" }
    let(:data) { JSON.dump({"op" => operation}) }

    it "returns correct instance of a messages class" do
      operation_class = Class.new(Struct.new(:data)) do
        def self.build(data)
          new(data)
        end
      end
      Providers::MtGox::Messages.stub(:get_class).with(operation) { operation_class }

      result = described_class.parse(data)
      expect(result).to be_a(operation_class)
      expect(result.data).to eq("op" => operation)
    end
  end
end
