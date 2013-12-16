class AddFieldsToGames < ActiveRecord::Migration
  def up
    add_column :games, :about, :text
    add_column :games, :resources, :text
  end

  def down
    remove_column :games, :about
    remove_column :games, :resources
  end
end
