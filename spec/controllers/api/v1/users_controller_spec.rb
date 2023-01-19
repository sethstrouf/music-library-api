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

  context 'When following users' do
    before do
      10.times do |n|
        first_name  = Faker::Name.first_name
        last_name  = Faker::Name.last_name
        email = "example-#{n+1}@mail.com"
        password = "TESTpassword123!"
        User.create!(first_name: first_name,
                     last_name: last_name,
                     email: email,
                     password: password,
                     password_confirmation: password
        )
      end

      users = User.order(:created_at)
      following = users[1..10]
      followers = users[5..10]
      following.each { |followed| user.follow(followed) }
      followers.each { |follower| follower.follow(user) }

      login(user)
    end

    it 'can get list of following users' do
      get "/api/v1/users/#{user.id}/following"
      expect(JSON.parse(response.body)['data'].count).to eq(9)
    end

    it 'can get list of followers' do
      get "/api/v1/users/#{user.id}/followers"
      expect(JSON.parse(response.body)['data'].count).to eq(5)
    end
  end
end
