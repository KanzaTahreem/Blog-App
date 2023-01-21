require_relative '../rails_helper'

RSpec.describe Like, type: :model do
  let(:user) { User.new(name: 'Tom & Jerry', photo: 'https://unsplash.com/photos/F_-0BxGuVvo', bio: 'Best friends', posts_counter: 0) }
  let(:post) { Post.new(title: 'The Great Adventure', text: 'The story of Tom and Jerry', author: user, comments_counter: 0, likes_counter: 0) }
  subject { Like.new(author: user, post: post) }
  
  before {subject.save }

  it "is valid with valid attributes" do
    expect(subject).to be_valid
  end

  it "is not valid without an author" do
    subject.author = nil
    expect(subject).to_not be_valid
  end

  it "is not valid without a post" do
    subject.post = nil
    expect(subject).to_not be_valid
  end

  it "increments the likes_counter of the associated post after saving" do
    expect { subject.save }.to change { post.reload.likes_counter }.by(1)
  end
end