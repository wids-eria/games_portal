class RemoveAdaIdFromUser < ActiveRecord::Migration
  def up
    remove_index :users, :ada_id
    remove_column :users, :ada_id
  end

  def down
    add_column :users, :ada_id, :integer
    add_index :users, :ada_id, :unique => true
  end
end
