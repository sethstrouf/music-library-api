class CreateLibraryWorks < ActiveRecord::Migration[7.0]
  def change
    create_table :library_works do |t|
      t.integer :index
      t.integer :quantity
      t.date :last_performed
      t.references :work, null: false, foreign_key: true
      t.references :library, null: false, foreign_key: true

      t.timestamps
    end
  end
end
