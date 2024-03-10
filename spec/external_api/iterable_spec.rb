require 'rails_helper'

RSpec.describe ExternalApi::Iterable::Handler do
  describe "when event request is submitted to Iterable" do
    it "returns success response" do
      request = ExternalApi::Iterable::Request::Event.new(event_name: "Event A", user_email: "test@iterable.com")
      handler = ExternalApi::Iterable::Handler.new(request: request)
      response = handler.submit!

      expect(response.response_code).to eq(200)
      expect(response.code).to eq("Success")
    end
  end

  describe "when email delivery request is submitted to Iterable" do
    it "returns success response" do
      request = ExternalApi::Iterable::Request::Email.new(user_email: "test@iterable.com")
      handler = ExternalApi::Iterable::Handler.new(request: request)
      response = handler.submit!

      expect(response.response_code).to eq(200)
      expect(response.code).to eq("Success")
    end
  end
end