class AddImageToGame < ActiveRecord::Migration
  def self.up
    add_attachment :games, :image
  end

  def self.down
    remove_attachment :games, :image
  end
end
