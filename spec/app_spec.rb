require "spec_helper"

describe GitlabNotifier do
  describe "GET /" do
    before do
      get "/"
    end

    it "responds with 200" do
      expect(last_response.status).to eq 200
    end

    it "returns version" do
      expect(last_response.body).to eq "Gitlab Slack Notifier v#{GitlabNotifier::VERSION}"
    end
  end

  describe "GET /test" do
    before do
      SlackNotify::Client.any_instance.stub(:test)
    end

    it "sends a test message" do
      expect_any_instance_of(SlackNotify::Client).to receive(:test)
      get "/test"
    end

    it "responds with OK" do
      get "/test"
      expect(last_response.body).to eq "OK"
    end
  end

  describe "POST /receive" do
    let(:payload) { fixture "commits.json" }

    context "with valid payload" do
      before do
        post "/receive", payload
      end

      it "responds with 200" do
        expect(last_response.status).to eq 200
      end

      it "returns OK" do
        expect(last_response.body).to eq "OK"
      end
    end

    context "with no payload" do
      before do
        post "/receive"
      end

      it "responds with 400" do
        expect(last_response.status).to eq 400
      end

      it "returns error message" do
        expect(last_response.body).to eq "Payload required"
      end
    end

    context "with non-json payload" do
      before do
        post "/receive", "foobar"
      end

      it "responds with 400" do
        expect(last_response.status).to eq 400
      end

      it "returns error message" do
        expect(last_response.body).to eq "Not a JSON payload"
      end
    end

    context "when debug env var is set" do
      before do
        ENV["DEBUG"] = "1"
        STDOUT.stub(:puts)

        post "/receive", payload
      end

      after do
        ENV["DEBUG"] = nil
      end

      it "prints payload to stdout" do
        expect(STDOUT).to have_received(:puts)
      end
    end
  end
end