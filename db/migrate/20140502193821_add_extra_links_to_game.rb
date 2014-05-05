class AddExtraLinksToGame < ActiveRecord::Migration
  def self.up
    add_attachment :games, :lesson_plan
    add_attachment :games, :cirriculum
    add_column :games, :microsite, :string
    add_column :games, :external_download, :string
    remove_column :games, :resources
  end

  def self.down
    add_column :games, :resources, :text
    remove_attachment :games, :cirriculum
    remove_attachment :games, :lesson_plan
    remove_column :games, :microsite
    remove_column :games, :external_download
  end
end
