class Api::V1::CurrentUserController < ApplicationController
  def index
    render json: Api::V1::UserSerializer.new(current_user).serializable_hash[:data][:attributes]
  end
end
