class Api::V1::SearchController < ApplicationController
  def search_works
    works = Work.search(search_works_params[:query])

    render json: Api::V1::WorkSerializer.new(works).serializable_hash[:data]
  end

  private

    def search_works_params
      params.require(:works_query).permit(:query)
    end
end
