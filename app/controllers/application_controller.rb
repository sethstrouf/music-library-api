class ApplicationController < ActionController::API
  before_action :authenticate_user!

  protected

  def current_user
    token = request&.headers['Authorization']&.split&.last
    Warden::JWTAuth::UserDecoder.new.call(token, :user, nil) if token.present?
  end
end
