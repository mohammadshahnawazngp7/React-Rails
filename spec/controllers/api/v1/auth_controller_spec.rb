require 'rails_helper'

RSpec.describe Api::V1::AuthController, type: :controller do
  let(:user) { create(:user) }
  let(:valid_credentials) { { email: user.email, password: 'password' } }
  let(:invalid_credentials) { { email: 'wrongemail@example.com', password: 'wrongpassword' } }
  let(:user_params) { { email: 'newuser@example.com', password: 'password', password_confirmation: 'password' } }
  let(:existing_user_params) { { email: user.email, password: 'password', password_confirmation: 'password' } }

  describe 'POST #sign_in' do
    context 'when credentials are valid' do
      it 'returns a success response with a token' do
        post :sign_in, params: { auth: valid_credentials }
        expect(response).to have_http_status(:ok)
        expect(response.body).to include('Signed in successfully')
        expect(response.body).to include('token')
      end
    end

    context 'when credentials are invalid' do
      it 'returns an unauthorized response with an error message' do
        post :sign_in, params: { auth: invalid_credentials }
        expect(response).to have_http_status(:unauthorized)
        expect(response.body).to include('Invalid email or password')
      end
    end
  end

  describe 'POST #sign_up' do
    context 'when email is already taken' do
      it 'returns an unprocessable entity response' do
        post :sign_up, params: { user: existing_user_params }
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.body).to include('Email already taken')
      end
    end

    context 'when user params are invalid' do
      it 'returns an unprocessable entity response with errors' do
        invalid_params = { email: '', password: 'short', password_confirmation: 'short' }
        post :sign_up, params: { user: invalid_params }
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.body).to include('error')
      end
    end
  end
end
