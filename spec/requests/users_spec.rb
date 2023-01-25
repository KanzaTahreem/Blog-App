require 'rails_helper'


RSpec.describe 'UsersController', type: :request do
  subject { User.new(name: 'Tom & Jerry', photo: 'https://unsplash.com/photos/F_-0BxGuVvo', bio: 'Best friends', posts_counter: 12) }

  before { subject.save } 

  describe "GET #index" do
    before(:example) { get users_path }

    it "returns http success" do
      expect(response).to have_http_status(:ok)
    end

    it "renders the correct template" do
      expect(response).to render_template(:index)
    end

    it "includes the correct placeholder text in the response body" do
      expect(response.body).to include("Hello from all users page!")
    end
  end

  
  describe "GET #show" do
    before(:example) { get user_path(id: 1) }

    it "returns http success" do
      expect(response).to have_http_status(:ok)
    end

    it "renders the correct template" do
      expect(response).to render_template(:show)
    end

    it "includes the correct placeholder text in the response body" do
      expect(response.body).to include("Hello from a selected user page!")
    end
  end
end