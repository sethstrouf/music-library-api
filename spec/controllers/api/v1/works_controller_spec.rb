require 'rails_helper'

describe Api::V1::WorksController, type: :request do
  before do
    @work_params = {
      title: 'Test Work',
      composer: 'Test Composer',
      genre: 'folk',
      publishing_year: 2008
    }

    @user = create_user
    login(@user)
  end

  describe 'GET #index' do
    before do
      5.times do |i|
        Work.create!(title: "Title #{i}", composer: "Composer #{i}")
      end
      get '/api/v1/works'
    end

    it 'returns works' do
      expect(JSON.parse(response.body).count).to eq(Work.count)
    end
  end

  describe 'POST #create' do
    before do
      post '/api/v1/works',
        params: {
          work: @work_params
        }
    end

    it 'creates new work' do
      expect(Work.first).to have_attributes(@work_params)
    end
  end

  describe 'GET #show' do
    before do
      @new_work = Work.create!(@work_params)
      get "/api/v1/works/#{@new_work.id}"
    end

    it 'returns work' do
      expect(JSON.parse(response.body)['id'].to_i).to eq(@new_work.id)
    end
  end

  describe 'PATCH #update' do
    before do
      @new_work = Work.create!(@work_params)
      patch "/api/v1/works/#{@new_work.id}",
        params: {
          work: {
            title: 'Updated Title'
          }
        }
    end

    it 'updates work' do
      expect(Work.first.title).to eq('Updated Title')
    end
  end

  describe 'DELETE #destroy' do
    before do
      @new_work = Work.create!(@work_params)
      delete "/api/v1/works/#{@new_work.id}"
    end

    it 'destroys work' do
      expect(Work.first).to_not be_present
    end
  end
end
