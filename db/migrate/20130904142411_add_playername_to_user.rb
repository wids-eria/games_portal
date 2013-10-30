class AddPlayernameToUser < ActiveRecord::Migration
  def up
    add_column :users, :player_name, :string
  end

  def remove
    remove_column :users, :player_name
  end
end
