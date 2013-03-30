if ENV["COVERAGE"] == "true"
  require "simplecov"
  require "coveralls"

  SimpleCov.formatter = SimpleCov::Formatter::MultiFormatter[
    SimpleCov::Formatter::HTMLFormatter,
    Coveralls::SimpleCov::Formatter
  ]

  SimpleCov.start
end

require "bitbot/live"

Dir[File.dirname(__FILE__) + "/shared/**/*.rb"].each {|f| require f}

include Bitbot::Live
