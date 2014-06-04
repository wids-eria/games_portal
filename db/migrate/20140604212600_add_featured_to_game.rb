class AddFeaturedToGame < ActiveRecord::Migration
  def up
    add_column :games, :featured, :boolean, default: false
  end

  def down
    remove_column :games, :featured
  end
end
