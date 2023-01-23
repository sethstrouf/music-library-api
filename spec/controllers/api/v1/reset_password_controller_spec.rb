require 'rails_helper'

describe Api::V1::UsersController, type: :request do

  let(:user) { create_user }

  describe 'POST #create' do
    context 'When requesting to reset password' do
      before do
        post "/api/v1/reset_password", params: { email: user.email }
      end

      it 'sends mailer' do
        expect(ActionMailer::Base.deliveries.last.subject).to eq('Songsemble: Reset Password')
      end
    end
  end

  describe 'POST #update_password' do
    context 'when token used within thirty minutes' do
      before do
        user.update!(
          reset_password_token: 'dc6eec399ab7dfe153c633712ada013',
          reset_password_sent_at: Time.now.utc
        )
        post "/api/v1/update_password",
          params: {
            reset_token: user.reset_password_token,
            password: 'NEWpassword123!'
          }
      end

      it 'returns ok' do
        expect(response.status).to be(200)
      end
    end

    context 'when token used outside of thirty minutes' do
      before do
        user.update!(
          reset_password_token: 'dc6eec399ab7dfe153c633712ada013',
          reset_password_sent_at: 31.minutes.ago
        )
        post "/api/v1/update_password",
          params: {
            reset_token: user.reset_password_token,
            password: 'NEWpassword123!'
          }
      end

      it 'returns forbidden' do
        expect(response.status).to be(403)
      end
    end
  end
end
