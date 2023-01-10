class Api::V1::SearchController < ApplicationController
  before_action :set_library, only: %i[search_library_works]

  def search_works
    works = Work.search(search_params[:query])

    render json: Api::V1::WorkSerializer.new(works).serializable_hash[:data]
  end

  def search_library_works
    library_works = @library.library_works.search(search_params[:query])

    render json: Api::V1::LibraryWorkSerializer.new(library_works).serializable_hash[:data]
  end

  private
    def set_library
      @library = Library.find(library_work_params[:library_id])
    end

    def search_params
      params.require(:works_query).permit(:query)
    end

    def library_work_params
      params.require(:library_work).permit(:library_id)
    end
end
