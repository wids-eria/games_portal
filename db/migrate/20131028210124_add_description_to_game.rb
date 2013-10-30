class AddDescriptionToGame < ActiveRecord::Migration
  def up
    add_column :games, :description, :text
  end

  def down
    remove_column :games, :description
  end
end
