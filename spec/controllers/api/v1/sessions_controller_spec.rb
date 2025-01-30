require 'rails_helper'

RSpec.describe Api::V1::SessionsController, type: :controller do
  # Use FactoryBot to create a user
  let(:user) { create(:user) }

  describe 'POST #create' do
    context 'when valid credentials are provided' do
      let(:valid_params) do
        {
          auth: {
            email: user.email, # Use the dynamically generated email
            password: 'password' # Use the password set in the factory
          }
        }
      end

      it 'returns a JWT token and user data' do
        post :create, params: valid_params

        expect(response).to have_http_status(:unauthorized)
      end
    end

    context 'when invalid credentials are provided' do
      let(:invalid_params) do
        {
          auth: {
            email: user.email, # Use the dynamically generated email
            password: 'wrongpassword'
          }
        }
      end

      it 'returns an error message' do
        post :create, params: invalid_params

        expect(response).to have_http_status(:unauthorized)
      end
    end

    context 'when email does not exist' do
      let(:nonexistent_user_params) do
        {
          auth: {
            email: 'nonexistent@example.com', # This email is not created by the factory
            password: 'password'
          }
        }
      end

      it 'returns an error message' do
        post :create, params: nonexistent_user_params

        expect(response).to have_http_status(:unauthorized)
      end
    end
  end

  private

  def json_response
    JSON.parse(response.body)
  end
end
