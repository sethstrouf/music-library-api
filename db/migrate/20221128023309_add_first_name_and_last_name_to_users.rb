class AddFirstNameAndLastNameToUsers < ActiveRecord::Migration[7.0]
  def up
    add_column :users, :first_name, :string, null: false, default: 'temp'
    add_column :users, :last_name, :string, null: false, default: 'temp'
    change_column :users, :first_name, :string, default: nil
    change_column :users, :last_name, :string, default: nil
  end

  def down
    remove_column :users, :first_name, :string
    remove_column :users, :last_name, :string
  end
end
