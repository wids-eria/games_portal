class RemoveFieldsFromGame < ActiveRecord::Migration
  def up
    remove_attachment :games, :lesson_plan
    remove_attachment :games, :cirriculum
  end

  def down

  end
end
