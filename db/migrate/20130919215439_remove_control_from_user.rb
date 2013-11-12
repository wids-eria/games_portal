class RemoveControlFromUser < ActiveRecord::Migration
  def up
    remove_column :users, :control_group
  end

  def down
    add_column :users, :control_group, :boolean
  end
end