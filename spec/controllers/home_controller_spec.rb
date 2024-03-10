require 'rails_helper'
require 'sidekiq/testing'

RSpec.describe HomeController, type: :controller do
  # Login user before each test case
  login_user

  describe "GET #index" do

    it "returns a success response when user is logged in" do
      get :index
      expect(response).to be_successful
      expect(response).to have_http_status(200)
    end

    it "sets counter hash in session if not present already" do
      get :index
      expect(session[:event_counter]).not_to be_nil
      expect(session[:event_counter]).to have_key("a")
      expect(session[:event_counter]).to have_key("b")
      expect(session[:event_counter]["a"]).to eq(0)
      expect(session[:event_counter]["b"]).to eq(0)
    end

    it "does not change counter hash if already present" do
      get :index, session: { event_counter: {"a" => 1, "b" => 2} }

      expect(session[:event_counter]).not_to be_nil
      expect(session[:event_counter]).to have_key("a")
      expect(session[:event_counter]).to have_key("b")
      expect(session[:event_counter]["a"]).to eq(1)
      expect(session[:event_counter]["b"]).to eq(2)
    end
  end

  describe "POST /generate/event" do
    before(:each) do
      Sidekiq::Worker.clear_all
    end

    context "when either event a or b is submitted" do
      it "enqueues event creation job" do
        post :event, params: {event: "a"}, session: { event_counter: {"a" => 0, "b" => 0} }

        queue = Sidekiq::Queue.new(EventCreationJob.queue_name)
        expect(queue.size).to eq(1)
      end

      it "increases session counter for event a" do
        post :event, params: {event: "a"}, session: { event_counter: {"a" => 0, "b" => 0} }

        expect(session[:event_counter]).to have_key("a")
        expect(session[:event_counter]).to have_key("b")
        expect(session[:event_counter]["a"]).to eq(1)
        expect(session[:event_counter]["b"]).to eq(0)
      end

      it "increases session counter for event b" do
        post :event, params: {event: "b"}, session: { event_counter: {"a" => 0, "b" => 0} }

        expect(session[:event_counter]).to have_key("a")
        expect(session[:event_counter]).to have_key("b")
        expect(session[:event_counter]["a"]).to eq(0)
        expect(session[:event_counter]["b"]).to eq(1)
      end
    end

    context "when neither event a nor b is submitted" do
      it "does not enqueue event creation job" do
        post :event, params: {event: "c"}, session: { event_counter: {"a" => 0, "b" => 0} }

        queue = Sidekiq::Queue.new(EventCreationJob.queue_name)
        expect(queue.size).to eq(0)
      end

      it "does not increase session counter" do
        post :event, params: {event: "c"}, session: { event_counter: {"a" => 0, "b" => 0} }

        expect(session[:event_counter]).to have_key("a")
        expect(session[:event_counter]).to have_key("b")
        expect(session[:event_counter]["a"]).to eq(0)
        expect(session[:event_counter]["b"]).to eq(0)
      end
    end
  end
end
