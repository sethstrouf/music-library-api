require 'rails_helper'

describe Users::RegistrationsController, type: :request do

  let(:user) { build_user }
  let(:existing_user) { create_user }
  let(:signup_url) { '/api/signup' }

  context 'When creating a new user' do
    before do
      post signup_url, params: {
        user: {
          email: user.email,
          password: user.password,
          first_name: user.first_name,
          last_name: user.last_name
        }
      }
    end

    it 'returns 200' do
      expect(response.status).to eq(200)
    end

    it 'returns a token' do
      expect(response.headers['Authorization']).to be_present
    end

    it 'returns the user email' do
      expect(json['data']['email']).to eq(user.email)
    end
  end

  context 'When updating a user' do
    before do
      login(existing_user)

      patch signup_url,
        params: {
          user: {
            first_name: 'firstTest',
            last_name: 'lastTest'
          }
        },
        headers: {
          'Authorization': response.headers['Authorization']
        }
    end

    it 'updates first name and last name' do
      expect(existing_user.reload.first_name).to eq('firstTest')
      expect(existing_user.reload.last_name).to eq('lastTest')
    end
  end

  context 'When an email already exists' do
    before do
      post signup_url, params: {
        user: {
          email: existing_user.email,
          password: existing_user.password
        }
      }
    end

    it 'returns 400' do
      expect(response.status).to eq(422)
    end

    it 'returns email has already been taken error' do
      expect(json['status']['message']).to eq("User couldn't be created successfully. Email has already been taken")
    end
  end
end
