require "spec_helper"

describe MtGox::Messages::Message do
  it { should_not be_status }
  it { should_not be_private }
end
