class ApplicationController < ActionController::API
  include ActionController::HttpAuthentication::Token::ControllerMethods
  # before_action :authorized

  def issue_token(payload)
    JWT.encode(payload, "supersecretcode")
  end

  def current_user
      begin
        jwt_token = params[:token]
        decoded_token = JWT.decode(jwt_token, "supersecretcode")
        rescue JWT::DecodeError
        return nil
      end
      if decoded_token[0]["user_id"]
        @current_user ||= User.find(decoded_token[0]["user_id"])
      else
      end
  end

  def logged_in?
    !!current_user
  end

end
