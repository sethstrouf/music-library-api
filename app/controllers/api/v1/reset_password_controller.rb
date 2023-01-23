class Api::V1::ResetPasswordController < ApplicationController
  skip_before_action :authenticate_user!

  def create
    @user = User.find_by(email: params[:email])
    raw, hashed = Devise.token_generator.generate(User, :reset_password_token)

    if @user.update(reset_password_token: hashed, reset_password_sent_at: Time.now.utc)
      UserMailer.reset_password(@user).deliver_now
      render json: { status: :ok }
    else
      render json: @user.errors, status: :internal_server_error
    end
  end

  def update_password
    user = User.find_by(reset_password_token: params[:reset_token])

    if user.reset_password_sent_at.between?(30.minutes.ago, Time.now.utc) && user.update(password: params[:password])
      render json: Api::V1::UserSerializer.new(user.reload).serializable_hash, status: :ok
    else
      render json: user.errors, status: :forbidden
    end
  end

  private

    def reset_password_params
      params.permit(:email, :reset_token, :password)
    end
end
