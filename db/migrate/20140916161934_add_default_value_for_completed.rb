class AddDefaultValueForCompleted < ActiveRecord::Migration
  def up
    change_column :achievements, :completed, :boolean, :default => false
  end

end
