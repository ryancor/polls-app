require 'rails_helper'
require 'spec_helper'

RSpec.describe "All routes", :type => :routing do
  describe "GET routes" do
    it "re-routes successfully" do
    	expect(get("/polls")).to route_to("polls#index")
    end
    it "routes to user profile" do
      expect(get("/profile")).to route_to("users#show")
    end
  end
end