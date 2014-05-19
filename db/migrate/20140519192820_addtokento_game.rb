class AddtokentoGame < ActiveRecord::Migration
  def up
    add_column :games, :token, :string
  end

  def down
    remove_column :games, :token
  end
end
