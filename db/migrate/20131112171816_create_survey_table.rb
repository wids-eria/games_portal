class CreateSurveyTable < ActiveRecord::Migration
  def up
    create_table :surveys do |t|
      t.string :url
      t.integer :game_id
      t.timestamps
    end
  end

  def down
    drop_table :surveys
  end
end
