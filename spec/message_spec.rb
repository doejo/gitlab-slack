require "spec_helper"

describe Message do
  let(:message) { described_class.new(payload) }

  describe "#to_s" do
    let(:result) { message.to_s }

    %w(new_branch deleted_branch commit commits no_commits).each do |name|
      it "renders message for #{name.sub(/_/, " ")}" do
        payload = Payload.new(json_fixture("#{name}.json"))
        result  = fixture("messages/#{name}.txt")

        expect(described_class.new(payload).to_s).to eq result
      end
    end
  end
end