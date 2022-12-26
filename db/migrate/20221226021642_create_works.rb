class CreateWorks < ActiveRecord::Migration[7.0]
  def change
    create_table :works do |t|
      t.integer :index
      t.string :title, null: false
      t.string :composer, null: false
      t.string :genre
      t.integer :publishing_year

      t.timestamps
    end
  end
end
