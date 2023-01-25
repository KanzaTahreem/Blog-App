require 'rails_helper'


RSpec.describe 'UsersController', type: :request do
  subject { User.new(name: 'Tom & Jerry', photo: 'https://unsplash.com/photos/F_-0BxGuVvo', bio: 'Best friends', posts_counter: 12) }

  before { subject.save } 

  describe "GET #index" do
    before(:example) { get users_path } # get(:index)
    it "returns http success" do
      # get '/users'
      # get users_path
      expect(response).to have_http_status(:ok)
    end

    it "renders the correct template" do
      # get '/users'
      # get users_path
      expect(response).to render_template(:index)
    end

    it "includes the correct placeholder text in the response body" do
      # get '/users'
      # get users_path
      expect(response.body).to include("Hello from all users page!")
    end
  end
end