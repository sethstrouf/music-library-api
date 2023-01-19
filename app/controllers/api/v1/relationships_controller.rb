class Api::V1::RelationshipsController < ApplicationController
  def create
    followed_user = User.find(params[:followed_id])
    current_user.follow(followed_user)
    render json: Api::V1::UserSerializer.new(followed_user).serializable_hash
  end

  def destroy
    unfollow_user = User.find(params[:id])
    current_user.unfollow(unfollow_user)
    render json: Api::V1::UserSerializer.new(unfollow_user).serializable_hash
  end
end
