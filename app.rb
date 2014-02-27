require "bundler/setup"
require "sinatra"
require "slack-notify"
require "hashr"
require "erb"

require "./lib/payload"
require "./lib/message"

["SLACK_TEAM", "SLACK_TOKEN", "SLACK_CHANNEL"].each do |var|
  raise "#{var} required" if ENV[var].nil?
end

class GitlabNotifier < Sinatra::Base
  VERSION = "0.1.0"

  def client
    @client ||= SlackNotify::Client.new(ENV["SLACK_TEAM"], ENV["SLACK_TOKEN"], {
      channel: ENV["SLACK_CHANNEL"],
      username: ENV["SLACK_USER"] || "gitlab"
    })
  end

  get "/" do
    "Gitlab Slack Notifier v#{VERSION}"
  end

  get "/test" do
    client.test
    "OK"
  end

  post "/receive" do
    body = request.body.read

    if ENV["DEBUG"]
      STDOUT.puts(body.inspect)
    end

    if body.empty?
      halt 400, "Payload required"
    end

    payload = Payload.new(JSON.load(body)) rescue nil

    if payload.nil?
      halt 400, "Not a JSON payload"
    end

    client.notify(Message.new(payload).to_s)

    "OK"
  end
end