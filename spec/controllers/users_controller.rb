require 'rails_helper'
require 'spec_helper'

def valid_attributes
  {"email" => "hoge@hogehoge.com",
   "name" => "Ho Dodge"}
end

def valid_session
  {}
end

RSpec.describe UsersController, :type => :controller do
  describe "GET show" do
    it "shows nil user" do
      user = User.create! valid_attributes
      get :show, id: user.id
      assigns(:user).should eq(nil)
    end
  end

  describe "POST update" do
    it "user update succeeds" do
      user = User.create! valid_attributes
      about = AboutMe.create!(bio: 'hey', user_id: user.to_param)
      post :update, {:slug => user.slug}, {:bio => about.bio }, valid_session
      assigns(:user).should eq(user)
    end
  end

  describe "GET current users" do
    it "should show valid name" do
      get('/users/qgldDzfmJNO-ryan-cornateanu')[:name].should == "Ryan Cornateanu"
    end
    it "should show a 404" do
      get('/users/HAJdDzfass').code.should == 404
    end
  end
end