class CreateAchievements < ActiveRecord::Migration
  def change
    create_table :achievements do |t|
      t.references :user
      t.column :last_result, :json
      t.column :name, :string
      t.column :description, :string
      t.column :completed, :bool
      t.column :last_queried, :datetime
      t.timestamps
    end
  end
end
