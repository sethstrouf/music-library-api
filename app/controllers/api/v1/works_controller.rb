class Api::V1::WorksController < ApplicationController
  before_action :set_work, only: %i[show update destroy]

  def index
    works = Work.all

    render json: Api::V1::WorkSerializer.new(works).serializable_hash[:data]
  end

  def create
    work = Work.new(work_params)

    if work.save
      render json: Api::V1::WorkSerializer.new(work).serializable_hash
    else
      render json: work.errors, status: :unprocessable_entity
    end
  end

  def show
    render json: Api::V1::WorkSerializer.new(@work).serializable_hash[:data]
  end

  def update
    if @work.update(work_params)
      render json: Api::V1::WorkSerializer.new(@work).serializable_hash
    else
      render json: @work.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @work.destroy!
  end

  private
    def set_work
      @work = Work.find(params[:id])
    end

    def work_params
      params.require(:work).permit(:index, :title, :composer, :genre, :publishing_year)
    end
end
