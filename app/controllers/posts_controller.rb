class PostsController < ApplicationController
  def index
    offset = params[:offset] ? params[:offset].to_i : 0
    limit = 5
    @user = User.find(params[:user_id])
    @posts = @user.posts.order(created_at: :asc).limit(5).offset(offset)
    @total_posts = @user.posts.count
    @total_pages = (@total_posts.to_f / limit.to_f).ceil
    @current_page = (offset / limit )
  end

  def show
    @user = User.find(params[:user_id])
    @post = @user.posts.find(params[:id])
  end
end
