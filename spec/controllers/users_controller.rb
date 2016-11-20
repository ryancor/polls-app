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
end