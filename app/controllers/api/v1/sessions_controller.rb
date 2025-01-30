module Api
    module V1
        class SessionsController < ApplicationController
            # POST /api/v1/auth/sign_in
            def create
                user = User.find_by(email: params[:auth][:email])
                
                if user && user.valid_password?(params[:auth][:password])
                    token = encode_token(user)
                    render json: { token: token, user: user }, status: :ok
                else
                    render json: { errors: ['Invalid credentials'] }, status: :unauthorized
                end
            end
            
            private
            
            def encode_token(user)
                JWT.encode({ user_id: user.id }, Rails.application.secret_key_base, 'HS256')
            end
        end
    end
end
