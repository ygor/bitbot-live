shared_examples_for "a private message" do
  it { should respond_to(:type) }
  it { should be_private }
end
