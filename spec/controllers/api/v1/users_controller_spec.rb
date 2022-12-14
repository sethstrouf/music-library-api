require 'rails_helper'

describe Api::V1::UsersController, type: :request do

  let(:user) { create_user }

  context 'When fetching a user' do
    before do
      login(user)
      get "/api/v1/users/#{user.id}", headers: {
        'Authorization': response.headers['Authorization']
      }
    end

    it 'returns 200' do
      expect(response.status).to eq(200)
    end

    it 'returns the user' do
      expect(json['data']).to have_id(user.id.to_s)
      expect(json['data']).to have_type('user')
    end
  end

  context 'When the Authorization header is missing' do
    before do
      get "/api/v1/users/#{user.id}"
    end

    it 'returns 401' do
      expect(response.status).to eq(401)
    end
  end
end
