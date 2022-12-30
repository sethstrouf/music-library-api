class Api::V1::LibraryWorksController < ApplicationController
  before_action :set_library, only: %i[index create]
  before_action :set_library_work, only: %i[show update destroy]

  def index
    library_works = @library.library_works.all

    render json: Api::V1::LibraryWorkSerializer.new(library_works).serializable_hash[:data]
  end

  def create
    library_work = @library.library_works.build(library_work_params)

    if library_work.save
      render json: Api::V1::LibraryWorkSerializer.new(library_work).serializable_hash
    else
      render json: library_work.errors, status: :unprocessable_entity
    end
  end

  def show
    render json: Api::V1::LibraryWorkSerializer.new(@library_work).serializable_hash[:data]
  end

  def update
    if @library_work.update(library_work_params)
      render json: Api::V1::LibraryWorkSerializer.new(@library_work).serializable_hash[:data]
    else
      render json: @library_work.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @library_work.destroy!
  end

  private
    def set_library_work
      @library_work = LibraryWork.find(params[:id])
    end

    def set_library
      @library = Library.find(library_work_params[:library_id])
    end

    def library_work_params
      params.require(:library_work).permit(:index, :quantity, :last_performed, :work_id, :library_id)
    end
end
