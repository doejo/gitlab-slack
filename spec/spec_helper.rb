ENV["RACK_ENV"] = "test"

# Initialize fake slack environment vars
ENV["SLACK_TEAM"]    = "team"
ENV["SLACK_TOKEN"]   = "token"
ENV["SLACK_CHANNEL"] = "channel"
ENV["SLACK_USER"]    = "user"

require "simplecov"
SimpleCov.start

require "sinatra"
require "rack/test"
require "json"
require "webmock"

require "./app"

RSpec.configure do |config|
  config.include Rack::Test::Methods
end

def fixture_path
  File.expand_path("../fixtures", __FILE__)
end

def fixture(file)
  File.read(File.join(fixture_path, file))
end

def json_fixture(file)
  JSON.load(fixture(file))
end

def app
  GitlabNotifier
end