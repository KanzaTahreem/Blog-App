require 'rails_helper'


RSpec.describe 'PostsController', type: :request do
  user = User.create(name: 'Tom & Jerry', photo: 'https://unsplash.com/photos/F_-0BxGuVvo', bio: 'Best friends', posts_counter: 12)
  subject do
    Post.new(title: 'Physics', text: 'This is not my first post', comments_counter: 10, likes_counter: 10,
             author: user)
  end

  before { subject.save } 

  describe "GET #index" do
    before(:each) { get user_posts_path(user_id: 1) }

    it "returns http success" do
      expect(response).to have_http_status(:ok)
    end

    it "renders the correct template" do
      expect(response).to render_template(:index)
    end

    it "includes the correct placeholder text in the response body" do
      expect(response.body).to include("Hello from user's all posts page!")
    end
  end

  describe "GET #show" do
    before(:each) { get user_post_path(user_id: 1, id: 1) }

    it "returns http success" do
      expect(response).to have_http_status(:ok)
    end

    it "renders the correct template" do
      expect(response).to render_template(:show)
    end

    it "includes the correct placeholder text in the response body" do
      expect(response.body).to include("Hello from a selected post page!")
    end
  end
end