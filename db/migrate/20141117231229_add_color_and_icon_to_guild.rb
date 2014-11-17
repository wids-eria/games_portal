class AddColorAndIconToGuild < ActiveRecord::Migration
  def change
    add_column :guilds, :icon_cd, :integer
    add_column :guilds, :color_cd, :integer
  end
end
