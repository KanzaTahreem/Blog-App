class UsersController < ApplicationController
  def index
    @users = User.all.order(id: :asc)
  end

  def show
    @user = User.find(params[:id])
    @recent_posts = @user.recent_posts
  end

  # private

  # def user_params
  #   params.require(:user).permit(:name, :email, :password, :password_confirmation)
  # end
end
