require "spec_helper"

describe Listenable do
  subject { listenable.type }

  let(:listenable) { Class.new.extend(described_class) }

  before { listenable.stub(:name) { "Prefix::Sweet" } }

  it { should eq("sweet") }
end
