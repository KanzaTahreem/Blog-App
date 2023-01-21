require_relative '../rails_helper'

RSpec.describe User, type: :model do
  subject { User.new(name: 'Tom & Jerry', photo: 'https://unsplash.com/photos/F_-0BxGuVvo', bio: 'Best friends') }

  before { subject.save }

  it 'name should be present' do
    subject.name = nil
    expect(subject).to_not be_valid
  end

  it 'name should not be too short' do
    subject.name = 'a'
    expect(subject).to_not be_valid
  end

  it 'name should not be too long' do
    subject.name = 'a' * 30
    expect(subject).to_not be_valid
  end

  it 'name should be b/w 3 and 25 words' do
    subject.name = 'a' * 5
    expect(subject).to be_valid
  end

  it 'name should have valid value' do
    expect(subject.name).to eql 'Tom & Jerry'
  end

  it 'photo should be present' do
    subject.photo = nil
    expect(subject).to_not be_valid
  end

  it 'photo should have valid value' do
    expect(subject.photo).to eql 'https://unsplash.com/photos/F_-0BxGuVvo'
  end

  it 'bio should be present' do
    subject.bio = nil
    expect(subject).to_not be_valid
  end

  it 'bio should have vaid value' do
    expect(subject.bio).to eql 'Best friends'
  end

  it 'posts_counter must not be less than 1' do
    subject.posts_counter = -1
    expect(subject).to_not be_valid
  end

  it 'should have posts counter greater than or euqal to 0' do
    subject.posts_counter = 0
    expect(subject).to be_valid
  end

  it 'should return 3 recent posts' do
    expect(subject.recent_posts).to eq(subject.posts.order(created_at: :desc).limit(3))
  end
end
