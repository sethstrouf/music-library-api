require 'rails_helper'

describe Api::V1::CurrentUserController, type: :request do

  let(:user) { create_user }

  context 'When fetching current user' do
    before do
      login(user)
      get "/api/v1/current_user", headers: {
        'Authorization': response.headers['Authorization']
      }
    end

    it 'returns current user' do
      expect(JSON.parse(response.body)['id']).to eq(user.id)
    end
  end
end
