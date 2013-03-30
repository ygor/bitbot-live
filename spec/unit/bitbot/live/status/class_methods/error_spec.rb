require "spec_helper"

describe Status, ".error" do
  subject { described_class.error("Oops") }

  its(:type) { should eq("error") }
  its(:body) { should eq("Oops") }
end
