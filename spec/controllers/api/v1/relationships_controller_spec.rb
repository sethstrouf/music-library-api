require 'rails_helper'

describe Api::V1::RelationshipsController, type: :request do
  before do
    @current_user = User.create!(email: Faker::Internet.email, password: Faker::Internet.password, first_name: Faker::Name.first_name, last_name: Faker::Name.last_name)
    @followed_user = User.create!(email: Faker::Internet.email, password: Faker::Internet.password, first_name: Faker::Name.first_name, last_name: Faker::Name.last_name)
    login(@current_user)
  end

  context 'When following user' do
    before do
      post "/api/v1/relationships",
        params: { followed_id: @followed_user.id },
        headers: {
          'Authorization': response.headers['Authorization']
        }
    end

    it 'returns followed user' do
      expect(@current_user.following.first).to eq(@followed_user)
      expect(@followed_user.followers.first).to eq(@current_user)
      expect(JSON.parse(response.body)['data']['id']).to eq(@followed_user.id.to_s)
    end
  end

  context 'When unfollowing user' do
    before do
      @current_user.follow(@followed_user)
      delete "/api/v1/relationships/#{@followed_user.id}", headers: {
        'Authorization': response.headers['Authorization']
      }
    end

    it 'returns unfollowed user' do
      expect(@current_user.following.count).to eq(0)
      expect(@followed_user.followers.count).to eq(0)
      expect(JSON.parse(response.body)['data']['id']).to eq(@followed_user.id.to_s)
    end
  end
end
