class AddGamesReferencetoAchievement < ActiveRecord::Migration
  def up
    add_column :achievements, :game_id, :integer, references: :games
  end

  def down
    remove_column :achievements, :game_id
  end
end
