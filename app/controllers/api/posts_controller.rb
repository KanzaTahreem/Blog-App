require 'jwt'

class Api::PostsController < Api::ApplicationController
  before_action :find_user, only: [:index]

  def index
    if @user
      @posts = @user.posts.order(created_at: :asc)
      render json: @posts
    else
      render json: { status: 'Failure', error: 'User Not Found' }
    end
  end

  private

  def find_user
    @user = User.find_by_id(params[:user_id])
  end
end
