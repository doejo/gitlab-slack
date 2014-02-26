require "bundler/setup"
require "sinatra"
require "slack-notify"

["SLACK_TEAM", "SLACK_TOKEN", "SLACK_CHANNEL"].each do |var|
  raise "#{var} required" if ENV[var].nil?
end

class GitlabNotifier < Sinatra::Base
  VERSION = "0.1.0"

  get "/" do
    "Gitlab Slack Notifier v#{VERSION}"
  end
end