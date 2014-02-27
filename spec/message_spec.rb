require "spec_helper"

describe Message do
  let(:message) { described_class.new(payload) }

  describe "#to_s" do
    let(:result) { message.to_s }

    context "for new branch" do
      let(:payload) { Payload.new(json_fixture "new_branch.json") }

      it "returns new branch message" do
        expect(result).to eq fixture "messages/new_branch.txt"
      end
    end

    context "for deleted branch" do
      let(:payload) { Payload.new(json_fixture "deleted_branch.json") }

      it "returns deleted branch message" do
        expect(result).to eq fixture "messages/deleted_branch.txt"
      end
    end

    context "for a single commit" do
      let(:payload) { Payload.new(json_fixture "commit.json") }

      it "returns a single commit message" do
        expect(result).to eq fixture "messages/commit.txt"
      end
    end

    context "for multiple commits" do
      let(:payload) { Payload.new(json_fixture "commits.json") }

      it "returns multiple commits message" do
        expect(result).to eq fixture "messages/commits.txt"
      end
    end

    context "for push with no commits" do
      let(:payload) { Payload.new(json_fixture "no_commits.json") }

      it "returns only push message" do
        expect(result).to eq fixture "messages/no_commits.txt"
      end
    end
  end
end