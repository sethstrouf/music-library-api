class Api::V1::UsersController < ApplicationController
  before_action :set_user, only: %i[show update]

  def index
    users = User.all

    render json: Api::V1::UserSerializer.new(users).serializable_hash
  end

  def show
    render json: Api::V1::UserSerializer.new(@user).serializable_hash
  end

  # POST /users
  # def create
  #   user = User.new(user_params)

  #   if user.save
  #     render json: Api::V1::UserSerializer.new(user).serializable_hash
  #   else
  #     render json: user.errors, status: :unprocessable_entity
  #   end
  # end

  # PATCH/PUT /users/1
  def update
    if params[:photo].present?
      @user.profile_photo.attach(params[:photo])
    elsif @user.update(user_params)
      render json: Api::V1::UserSerializer.new(@user).serializable_hash
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  end

  # DELETE /users/1
  # def destroy
  #   @user.destroy
  # end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def user_params
      if params[:photo].present?
        params.permit(:photo)
      else
        params.require(:user).require(:attributes).permit(:email)
      end
    end
end
