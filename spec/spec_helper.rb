if ENV["COVERAGE"] == "true"
  require "simplecov"
  SimpleCov.start
end

require "bitbot/live"

Dir[File.dirname(__FILE__) + "/shared/**/*.rb"].each {|f| require f}

include Bitbot::Live
