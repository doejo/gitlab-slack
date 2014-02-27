require "bundler/setup"
require "sinatra"
require "slack-notify"
require "hashr"
require "./lib/message"

["SLACK_TEAM", "SLACK_TOKEN", "SLACK_CHANNEL"].each do |var|
  raise "#{var} required" if ENV[var].nil?
end

class GitlabNotifier < Sinatra::Base
  VERSION = "0.1.0"

  get "/" do
    "Gitlab Slack Notifier v#{VERSION}"
  end

  post "/receive" do
    payload = params[:payload]

    if ENV["DEBUG"]
      STDOUT.puts(payload.inspect)
    end

    if payload.nil?
      halt 400, "Payload required"
    end

    "OK"
  end
end