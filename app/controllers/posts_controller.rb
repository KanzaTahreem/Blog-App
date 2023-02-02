class PostsController < ApplicationController
  load_and_authorize_resource

  before_action :find_user, only: %i[index new show]

  def index
    @posts = @user.posts.order(created_at: :asc)
  end

  def show
    @post = @user.posts.find(params[:id])
  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    @post.author = current_user

    if @post.save
      redirect_to user_posts_path(current_user), notice: 'Post created successfully'
    else
      flash.now[:alert] = @post.errors.full_messages.first if @post.errors.any?
      render :new, status: 400
    end
  end

  private

  def find_user
    # @user = User.find(params[:user_id])
    @user = User.includes(:posts, posts: [:comments, { comments: [:author] }]).find(params[:user_id])
  end

  def post_params
    params.require(:post).permit(:title, :text)
  end
end
