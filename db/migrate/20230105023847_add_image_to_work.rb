class AddImageToWork < ActiveRecord::Migration[7.0]
  def change
    add_column :works, :image_url, :string
  end
end
