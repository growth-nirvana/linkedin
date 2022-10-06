require "spec_helper"

RSpec.describe Linkedin::Authentication do
  describe "#access_token" do
    subject do
      described_class.new.access_token(
        code: code,
        client_id: client_id,
        client_secret: client_secret,
        redirect_uri: redirect_uri
      )
    end

    let(:code) { "code" }
    let(:client_id) { "client_id" }
    let(:client_secret) { "client_secret" }
    let(:redirect_uri) { "http://example.com" }

    context "when the request is successful" do
      let(:response) { double(:response, code: 200, body: body, success?: true, parsed_response: JSON.parse(body)) }
      let(:body) do
        {
          access_token: "t0k3n",
          expires_in: 5184000
        }.to_json
      end

      let(:code) { 0 }

      before do
        allow(HTTParty).to receive(:post).and_return(response)
      end

      it "returns the access token" do
        expect(subject).to include(
          "access_token" => "t0k3n",
          "expires_in" => 5184000
        )
      end
    end
  end
end