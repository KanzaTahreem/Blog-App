require 'jwt'

class Api::LoginController < Api::ApplicationController
  skip_before_action :authenticate_user
  @hmac_secret = 'my$ecretK3y'
  def index
    @user = User.find_by_email(params[:email])
    if @user&.valid_password?(params[:password])
      payload = {
        id: @user.id,
        name: @user.name,
        email: @user.email
      }
      token = JWT.encode payload, Api::LoginController.hmac_secret, 'HS256'
      render json: { token: token }
    else
      render json: { name: 'Fail' }
    end
  end
  
  class << self
    attr_reader :hmac_secret
  end
end
