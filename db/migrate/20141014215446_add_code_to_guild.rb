class AddCodeToGuild < ActiveRecord::Migration
  def change
    add_column :guilds, :code, :string
  end
end
