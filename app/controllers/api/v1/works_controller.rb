class Api::V1::WorksController < ApplicationController
  before_action :set_work, only: %i[show]

  def index
    works = Work.all

    render json: Api::V1::WorkSerializer.new(works).serializable_hash[:data]
  end

  def create
    authorize work = Work.new(work_params)

    if work.save
      render json: Api::V1::WorkSerializer.new(work).serializable_hash
    else
      render json: work.errors, status: :unprocessable_entity
    end
  end

  def show
    work = Work.find(params[:id])
    render json: Api::V1::WorkSerializer.new(@work).serializable_hash[:data]
  end

  def update
    authorize work = Work.find(params[:id])

    if params[:image].present?
      work.image.attach(params[:image])
   elsif work.update!(work_params)
      render json: Api::V1::WorkSerializer.new(work).serializable_hash
    else
      render json: work.errors, status: :unprocessable_entity
    end
  end

  def destroy
    authorize work = Work.find(params[:id])
    work.destroy!
  end

  private
    def work_params
      if params[:image].present?
        params.permit(:image)
      else
        params.require(:work).permit(:title, :composer, :arranger, :editor, :lyricist, :genre,
          :text, :publisher, :publishing_year, :language, :duration, :tempo, :season,
          :ensemble, :voicing, :instrumentation, :difficulty)
      end
    end
end
