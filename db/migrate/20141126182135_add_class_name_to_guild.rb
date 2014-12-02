class AddClassNameToGuild < ActiveRecord::Migration
  def change
    add_column :guilds, :class_name, :string
  end
end
