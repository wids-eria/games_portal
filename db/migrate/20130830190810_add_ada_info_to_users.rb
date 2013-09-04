class AddAdaInfoToUsers < ActiveRecord::Migration
  def up
    add_column :users, :ada_id, :integer
    add_index :users, :ada_id, :unique => true
  end

  def remove
    remove_column :users, :ada_id
  end
end
