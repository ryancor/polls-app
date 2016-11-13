require 'rails_helper'
require 'spec_helper'

RSpec.describe PollsController, :type => :controller do
  describe "GET index" do
    it "has a 200 status code" do
      get :index
      expect(response.status).to eq(200)
    end
  end

  describe "POST create/:id & update/:id" do
  	it "creates a poll" do
	   poll_attributes = FactoryGirl.attributes_for(:poll)
  	   post :create, post: poll_attributes
  	   response.should redirect_to(root_path)
  	   Poll.last.topic.should == poll_attributes[:topic]
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