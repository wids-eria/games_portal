class AddTypetoAcheivement < ActiveRecord::Migration
  def up
    add_column :achievements, :type, :string
  end

  def down
    remove_column :achievements, :type
  end
end
