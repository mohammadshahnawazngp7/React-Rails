class Api::V1::AuthController < ApplicationController
  before_action :log_jwt_token
  before_action :authenticate_user!, only: [:sign_out]
  
  # POST /api/v1/auth/sign_in
  def sign_in
    user = User.find_by(email: params[:auth][:email].downcase)
    if user && user.valid_password?(params[:auth][:password])
      token = user.generate_jwt
      render json: { message: 'Signed in successfully', user: UserSerializer.new(user), token: token }, status: :ok
    else
      render json: { error: 'Invalid email or password' }, status: :unauthorized
    end
  end
  
  # POST /api/v1/auth/sign_up
  def sign_up
    user = User.new(user_params)
    if User.exists?(email: user.email)
      render json: { error: "Email already taken" }, status: :unprocessable_entity
      return
    end

    if user.save
      render json: user, status: :created
    else
      render json: { error: user.errors.full_messages }, status: :unprocessable_entity
    end
  end
  
  def sign_out
    render json: { message: "Successfully signed out" }, status: :ok
  end
  
  private
  
  def user_params
    params.require(:user).permit(:email, :password, :password_confirmation)
  end
  def log_jwt_token
    token = request.headers['Authorization']
  end
end
