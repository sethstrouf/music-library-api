require 'rails_helper'

describe Users::SessionsController, type: :request do

  let(:user) { create_user }
  let(:login_url) { '/api/login' }
  let(:logout_url) { '/api/logout' }

  context 'When logging in' do
    before do
      login(user)
    end

    it 'returns a token' do
      expect(response.headers['Authorization']).to be_present
    end

    it 'returns 200' do
      expect(response.status).to eq(200)
    end
  end

  context 'When password is missing' do
    before do
      post login_url, params: {
        user: {
          email: user.email,
          password: nil
        }
      }
    end

    it 'returns 401' do
      expect(response.status).to eq(401)
    end

    it 'returns invalid email or password error' do
      expect(response.body).to eq('Invalid Email or password.')
    end
  end

  context 'When logging out' do
    before do
      login(user)
      bearer_token = response.headers['Authorization']
      delete logout_url, headers: { 'Authorization' => bearer_token }
    end

    it 'returns 200' do
      expect(response).to have_http_status(200)
    end
  end
end
