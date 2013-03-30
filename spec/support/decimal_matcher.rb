RSpec::Matchers.define :be_decimal do |expected|
  match do |actual|
    actual == BigDecimal(expected.to_s)
  end
end
