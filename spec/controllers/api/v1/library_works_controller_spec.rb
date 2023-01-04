require 'rails_helper'

describe Api::V1::LibraryWorksController, type: :request do
  before do
    @user = create_user
    @library = @user.libraries.create!(name: 'Personal Library')
    @work = Work.create!(title: 'Test Work', composer: 'Test Composer', genre: 'folk', publishing_year: 2008)

    @library_work_params = {
      index: 3,
      quantity: 47,
      last_performed: Date.new(2022, 12, 18),
      work_id: @work.id,
      library_id: @library.id
    }

    login(@user)
  end

  describe 'GET #index' do
    before do
      5.times do |i|
        work = Work.create!(title: "Title #{i}", composer: "Composer #{i}")
        @library.library_works.create!(
          quantity: i,
          last_performed: Date.new(2022, 12, 18),
          work: work
        )
      end

      get '/api/v1/library_works',
        params: {
          library_work: {
            library_id: @library.id
          }
        }
    end

    it 'returns library works for a given library' do
      expect(JSON.parse(response.body).count).to eq(@library.library_works.count)
    end
  end

  describe 'POST #create' do
    before do
      post '/api/v1/library_works',
        params: {
          library_work: @library_work_params
        }
    end

    it 'creates new library work' do
      expect(@library.library_works.first).to have_attributes(@library_work_params)
    end
  end

  describe 'GET #show' do
    before do
      @new_library_work = @library.library_works.create!(@library_work_params)
      get "/api/v1/library_works/#{@new_library_work.id}"
    end

    it 'returns library work' do
      expect(JSON.parse(response.body)['id'].to_i).to eq(@new_library_work.id)
    end
  end

  describe 'PATCH #update' do
    before do
      @new_library_work = @library.library_works.create!(@library_work_params)
      patch "/api/v1/library_works/#{@new_library_work.id}",
        params: {
          library_work: {
            quantity: 95
          }
        }
    end

    it 'updates library work' do
      expect(@library.library_works.first.quantity).to eq(95)
    end
  end

  describe 'DELETE #destroy' do
    before do
      @new_library = @library.library_works.create!(@library_work_params)
      delete "/api/v1/library_works/#{@new_library.id}"
    end

    it 'destroys library work' do
      expect(@library.library_works.first).to_not be_present
    end
  end
end
