class RemoveAboutFromGame < ActiveRecord::Migration
  def up
    remove_column :games, :about
  end

  def down
    add_column :games, :about, :text
  end
end
