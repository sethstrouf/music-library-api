require 'rails_helper'

describe Api::V1::SearchController, type: :request do
  before do
    @user = create_user
    login(@user)
  end

  describe 'GET #search_works' do
    context 'When searching by title' do
      before do
        @dog_title = Work.create!(title: 'Dog and Song', composer: 'Test')
        cat_title = Work.create!(title: 'Cat and Song', composer: 'Test')
        @both_title = Work.create!(title: 'Cat and Dog', composer: 'Test')

        get "/api/v1/search_works",
          params: {
            works_query: {
              query: 'dog'
            }
          }
      end

      it 'returns accurate results' do
        results = JSON.parse(response.body)
        expect(results.count).to eq(2)
        expect(results.first['attributes']['title']).to eq(@dog_title.title)
        expect(results.second['attributes']['title']).to eq(@both_title.title)
      end
    end

    context 'When searching by composer' do
      before do
        @dog_composer = Work.create!(title: 'Test', composer: 'Dog')
        cat_composer = Work.create!(title: 'Test', composer: 'Cat')

        get "/api/v1/search_works",
          params: {
            works_query: {
              query: @dog_composer.composer
            }
          }
      end

      it 'returns accurate results' do
        results = JSON.parse(response.body)
        expect(results.count).to eq(1)
        expect(results.first['attributes']['composer']).to eq(@dog_composer.composer)
      end
    end

    context 'When searching by genre' do
      before do
        @dog_genre = Work.create!(genre: 'Dog', title: 'Test', composer: 'Test')
        cat_genre = Work.create!(genre: 'Cat', title: 'Test', composer: 'Test')

        get "/api/v1/search_works",
          params: {
            works_query: {
              query: @dog_genre.genre
            }
          }
      end

      it 'returns accurate results' do
        results = JSON.parse(response.body)
        expect(results.count).to eq(1)
        expect(results.first['attributes']['genre']).to eq(@dog_genre.genre)
      end
    end

    context 'When searching by publishing_year' do
      before do
        @year_1988 = Work.create!(publishing_year: 1988, title: 'Test', composer: 'Test')
        year_1999 = Work.create!(publishing_year: 1999, title: 'Test', composer: 'Test')

        get "/api/v1/search_works",
          params: {
            works_query: {
              query: @year_1988.publishing_year
            }
          }
      end

      it 'returns accurate results' do
        results = JSON.parse(response.body)
        expect(results.count).to eq(1)
        expect(results.first['attributes']['publishing_year']).to eq(@year_1988.publishing_year)
      end
    end

    context 'When searching by multiple columns' do
      before do
        @dog_title = Work.create!(title: 'Dog and Song', composer: 'Test')
        cat_title = Work.create!(title: 'Cat and Song', composer: 'Test')
        @dog_title_and_composer = Work.create!(title: 'Dog', composer: 'Dog')
        cat_composer = Work.create!(title: 'Test', composer: 'Cat')
        @dog_genre = Work.create!(genre: 'Dog', title: 'Test', composer: 'Test')
        cat_genre = Work.create!(genre: 'Cat', title: 'Test', composer: 'Test')
        @year_1988 = Work.create!(publishing_year: 1988, title: 'Test', composer: 'Test')
        year_1999 = Work.create!(publishing_year: 1999, title: 'Test', composer: 'Test')

        get "/api/v1/search_works",
          params: {
            works_query: {
              query: 'dog 1988'
            }
          }
      end

      it 'returns accurate results with sorting' do
        results = JSON.parse(response.body)
        expect(results.count).to eq(4)
        expect(results.first['id'].to_i).to eq(@dog_title_and_composer.id)
        expect(results.second['id'].to_i).to eq(@dog_title.id)
        expect(results.third['id'].to_i).to eq(@dog_genre.id)
        expect(results.fourth['id'].to_i).to eq(@year_1988.id)
      end
    end
  end
end
