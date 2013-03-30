source "https://rubygems.org"

# Specify your gem's dependencies in bitbot.gemspec
gemspec

group :development do
  gem "rake"
  gem "rspec"
  gem "yard", "~> 0.8.5"
end

group :metrics do
  gem "reek", git: "https://github.com/troessner/reek.git"
  gem "simplecov"
  gem "yardstick", "~> 0.9.5"
  gem "mutant",    "~> 0.2.20"
  gem "coveralls", "~> 0.6.2"
  gem "flay",      "~> 2.1.0"
  gem "flog",      "~> 3.2.3"
end
