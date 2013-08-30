class AddAdaInfoToUsers < ActiveRecord::Migration
  def up
    add_column :users, :ada_id, :integer
   # remove_column :users, :ada_id
   # remove_column :users, :ada_id
  end

  def remove
    remove_column :users, :ada_id
  end
end
