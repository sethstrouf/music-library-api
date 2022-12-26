class Api::V1::LibrariesController < ApplicationController
  before_action :set_library, only: %i[show update destroy]

  def index
    libraries = current_user.libraries.all

    render json: Api::V1::LibrarySerializer.new(libraries).serializable_hash[:data]
  end

  def create
    library = current_user.libraries.build(library_params)

    if library.save
      render json: Api::V1::LibrarySerializer.new(library).serializable_hash[:data]
    else
      render json: library.errors, status: :unprocessable_entity
    end
  end

  def show
    render json: Api::V1::LibrarySerializer.new(@library).serializable_hash[:data]
  end

  def update
    if @library.update(library_params)
      render json: Api::V1::LibrarySerializer.new(@library).serializable_hash[:data]
    else
      render json: @library.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @library.destroy!
  end

  private
    def set_library
      @library = Library.find(params[:id])
    end

    def library_params
      params.require(:library).permit(:name, :quantity, :last_performed)
    end
end
