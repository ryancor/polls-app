require 'rails_helper'
require 'support/factory_girl'

RSpec.describe PollsController, :type => :controller do
  describe "GET index" do
    it "has a 200 status code" do
      get :index
      expect(response.status).to eq(200)
    end
  end

  describe "POST create/:id & update/:id" do
  	it "creates a poll" do
	   poll = Poll.create!(topic: 'New title')
	   put :update, {:id => poll.to_param, :topic => 'Newer title' }
	   poll.reload
	   expect(poll.topic).to eq('Newer title')
	end
  end
end

RSpec.describe "All routes", :type => :routing do
  describe "GET routes" do
    it "re-routes successfully" do
    	expect(get("/polls")).to route_to("polls#index")
    end
  end
end