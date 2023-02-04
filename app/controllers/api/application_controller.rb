class Api::ApplicationController < ActionController::API
  before_action :authenticate_user
  before_action :configure_permitted_parameters, if: :devise_controller?

  rescue_from CanCan::AccessDenied do |exception|
    redirect_to root_url, alert: exception.message
  end

  def after_sign_out_path_for(scope)
    new_user_session_path
  end

  protected

  def authenticate_user
    begin
      header = request.headers['Authorization']
      header = header.split(' ').last if header
      decoded_token = JWT.decode header, Api::LoginController.hmac_secret, true, { algorithm: 'HS256' }
      payload = decoded_token[0]
      if payload && payload["id"]
        @auth_user = User.find_by_id(payload["id"])
      end
    rescue JWT::VerificationError
      render json: {
        msg: "Invalid Token"
      }
    end
  end

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: %i[email name password password_confirmation])
  end
end
