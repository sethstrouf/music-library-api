require 'rails_helper'

describe Api::V1::LibrariesController, type: :request do
  before do
    @library_params = {
      name: 'Test Library',
    }

    @user = create_user
    login(@user)
  end

  describe 'GET #index' do
    before do
      5.times do |i|
        @user.libraries.create!(name: "Name #{i}")
      end
      get '/api/v1/libraries',
        headers: {
          'Authorization': response.headers['Authorization']
        }
    end

    it 'returns libraries for current user' do
      expect(JSON.parse(response.body).count).to eq(@user.libraries.count)
    end
  end

  describe 'POST #create' do
    before do
      post '/api/v1/libraries',
        params: {
          library: @library_params
        },
        headers: {
          'Authorization': response.headers['Authorization']
        }
    end

    it 'creates new library' do
      expect(@user.libraries.first).to have_attributes(@library_params)
    end
  end

  describe 'GET #show' do
    before do
      @new_library = @user.libraries.create!(@library_params)
      get "/api/v1/libraries/#{@new_library.id}",
        headers: {
          'Authorization': response.headers['Authorization']
        }
    end

    it 'returns library' do
      expect(JSON.parse(response.body)['id'].to_i).to eq(@new_library.id)
    end
  end

  describe 'PATCH #update' do
    before do
      @new_library = @user.libraries.create!(@library_params)
      patch "/api/v1/libraries/#{@new_library.id}",
        params: {
          library: {
            name: 'Updated Name'
          }
        }
    end

    it 'updates library' do
      expect(@user.libraries.first.name).to eq('Updated Name')
    end
  end

  describe 'DELETE #destroy' do
    before do
      @new_library = @user.libraries.create!(@library_params)
      delete "/api/v1/libraries/#{@new_library.id}"
    end

    it 'destroys library' do
      expect(@user.libraries.first).to_not be_present
    end
  end
end
