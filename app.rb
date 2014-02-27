require "bundler/setup"
require "sinatra"
require "slack-notify"
require "hashr"
require "./lib/payload"
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
    payload = request.body.read

    if ENV["DEBUG"]
      STDOUT.puts(payload.inspect)
    end

    if payload.empty?
      halt 400, "Payload required"
    end

    json = JSON.load(payload) rescue nil

    if json.nil?
      halt 400, "Not a JSON payload"
    end

    "OK"
  end
end