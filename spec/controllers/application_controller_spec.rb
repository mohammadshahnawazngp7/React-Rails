# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ApplicationController, type: :controller do
  let(:user) { create(:user) }
  let(:valid_token) { JsonWebToken.encode(user_id: user.id) }
  let(:invalid_token) { 'invalid.token' }

  controller do
    before_action :authenticate_user!

    def index
      render json: { message: 'Success' }
    end
  end

  describe 'GET #index' do
    context 'when token is missing' do
      it 'returns an unauthorized response' do
        request.headers['Authorization'] = nil
        get :index
        expect(response).to have_http_status(:unauthorized)
        expect(response.body).to include('Token is missing')
      end
    end
  end
end
