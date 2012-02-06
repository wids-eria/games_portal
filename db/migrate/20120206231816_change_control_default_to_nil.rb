class ChangeControlDefaultToNil < ActiveRecord::Migration
  def up
    change_column_default(:users, :control_group, nil)
  end

  def down
    change_column_default(:users, :control_group, true)
  end
end
