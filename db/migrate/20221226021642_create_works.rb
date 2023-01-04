class CreateWorks < ActiveRecord::Migration[7.0]
  def change
    create_table :works do |t|
      t.string :title, null: false

      t.string :composer
      t.string :arranger
      t.string :editor

      t.string :lyricist
      t.string :text

      t.integer :publishing_year
      t.string  :publisher

      t.string :language
      t.string :duration
      t.string :tempo
      t.string :genre
      t.string :season

      t.string :ensemble
      t.string :voicing
      t.string :instrumentation

      t.string :difficulty

      t.timestamps
    end
  end
end
