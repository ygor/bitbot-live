source "https://rubygems.org"

# Remove when virtus 0.6 is released
gem "virtus", github: "solnic/virtus"

# Specify your gem's dependencies in bitbot.gemspec
gemspec

group :development do
  gem "devtools", git: "https://github.com/datamapper/devtools.git"
  eval File.read("Gemfile.devtools")
end
