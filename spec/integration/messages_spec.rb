require "spec_helper"

describe "Messages:" do
  it "parses a depth message" do
    raw_message = <<-JSON
      {"channel":"24e67e0d-1cad-4cc0-9e7a-f8523ef460fe","depth":{"currency":"USD","item":"BTC","now":"1364565663997994","price":"88.00001","price_int":"8800001","total_volume_int":"149884077","type":2,"type_str":"bid","volume":"0.06510994","volume_int":"6510994"},"op":"private","origin":"broadcast","private":"depth"}
    JSON

    message = Providers::MtGox::MessageParser.parse(raw_message)
    expect(message).to be_a(Depth)
    expect(message.price).to be_decimal(88.00001)
  end

  it "parses a trade message" do
    raw_message = <<-JSON
      {"channel":"dbf1dee9-4f2e-4a08-8cb7-748919a71b21","op":"private","origin":"broadcast","private":"trade","trade":{"amount":1.0005,"amount_int":"100050000","date":1364566666,"item":"BTC","price":71.06028,"price_currency":"EUR","price_int":"7106028","primary":"Y","properties":"market","tid":"1364566666210329","trade_type":"bid","type":"trade"}}
    JSON

    message = Providers::MtGox::MessageParser.parse(raw_message)
    expect(message).to be_a(Trade)
    expect(message).to be_bid
    expect(message.amount).to be_decimal(1.0005)

    price = message.price
    expect(price.value).to be_decimal(71.06028)
    expect(price.currency).to eq("EUR")
  end

  it "parses a ticker message" do
    raw_message = <<-JSON
      {"channel":"d5f06780-30a8-4a48-a2f8-7ed181b4a13f","op":"private","origin":"broadcast","private":"ticker","ticker":{"avg":{"currency":"USD","display":"$88.30862","display_short":"$88.31","value":"88.30862","value_int":"8830862"},"buy":{"currency":"USD","display":"$88.89748","display_short":"$88.90","value":"88.89748","value_int":"8889748"},"high":{"currency":"USD","display":"$94.99000","display_short":"$94.99","value":"94.99000","value_int":"9499000"},"last":{"currency":"USD","display":"$89.50000","display_short":"$89.50","value":"89.50000","value_int":"8950000"},"last_all":{"currency":"USD","display":"$89.50000","display_short":"$89.50","value":"89.50000","value_int":"8950000"},"last_local":{"currency":"USD","display":"$89.50000","display_short":"$89.50","value":"89.50000","value_int":"8950000"},"last_orig":{"currency":"USD","display":"$89.50000","display_short":"$89.50","value":"89.50000","value_int":"8950000"},"low":{"currency":"USD","display":"$75.00111","display_short":"$75.00","value":"75.00111","value_int":"7500111"},"now":"1364566575703933","sell":{"currency":"USD","display":"$89.50000","display_short":"$89.50","value":"89.50000","value_int":"8950000"},"vol":{"currency":"BTC","display":"155,069.16984285\u00a0BTC","display_short":"155,069.17\u00a0BTC","value":"155069.16984285","value_int":"15506916984285"},"vwap":{"currency":"USD","display":"$86.71296","display_short":"$86.71","value":"86.71296","value_int":"8671296"}}}
    JSON

    message = Providers::MtGox::MessageParser.parse(raw_message)
    expect(message).to be_a(Ticker)
    expect(message.average.value).to    be_decimal(88.30862)
    expect(message.buy.value).to        be_decimal(88.89748)
    expect(message.high.value).to       be_decimal(94.99)
    expect(message.last_trade.value).to be_decimal(89.5)
    expect(message.low.value).to        be_decimal(75.00111)
    expect(message.sell.value).to       be_decimal(89.5)
    expect(message.volume.size).to      be_decimal(155069.16984285)
  end

  it "parses a result message"
end
