class AddImageToUser < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :profile_photo_url, :string
  end
end
