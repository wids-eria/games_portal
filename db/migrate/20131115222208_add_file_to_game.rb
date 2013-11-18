class AddFileToGame < ActiveRecord::Migration
  def self.up
    add_attachment :games, :file
  end

  def self.down
    remove_attachment :games, :file
  end
end
