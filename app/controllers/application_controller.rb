class ApplicationController < ActionController::API
  before_action :authenticate_user!
  
  private
  
  def authenticate_user!
    token = request.headers['Authorization']&.split(' ')&.last
    if token
      begin
        decoded_token = JsonWebToken.decode(token)
        @current_user = User.find(decoded_token[:user_id])
      rescue JWT::DecodeError => e
        render json: { error: 'Invalid or expired token' }, status: :unauthorized
      end
    else
      render json: { error: 'Token is missing' }, status: :unauthorized
    end
  end
end