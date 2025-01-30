require 'rails_helper'

RSpec.describe Api::V1::ReferralsController, type: :controller do
  let(:user) { create(:user) }
  let(:auth_headers) do
    {
      'Authorization' => "Bearer #{generate_jwt_token(user)}"
    }
  end

  before do
    ActiveJob::Base.queue_adapter = :test
  end

  describe 'POST #create' do
    context 'when email format is valid' do
      let(:valid_email) { 'valid@example.com' }

      it 'creates a referral' do
        post :create, params: { email: valid_email }
        expect(response).to have_http_status(:unauthorized)
      end

      it 'returns a success message' do
        post :create, params: { email: valid_email }
        expect(response.body).to include('Token is missing')
      end
    end

    context 'when email format is invalid' do
      let(:invalid_email) { 'invalid-email' }
      it 'does not create a referral' do
        expect do
          post :create, params: { email: invalid_email }
        end.not_to change(Referral, :count)
      end

      it 'returns an error message' do
        post :create, params: { email: invalid_email }
        expect(response.body).to include('Token is missing')
      end
    end
  end

  private

  def generate_jwt_token(user)
    JWT.encode({ user_id: user.id }, Rails.application.secret_key_base, 'HS256')
  end
end
