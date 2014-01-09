class AddLocalToGame < ActiveRecord::Migration
  def up
    add_column :games, :localpath, :string
  end

  def down
    remove_column :games, :localpath
  end
end
