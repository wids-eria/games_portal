class CreateGuilds < ActiveRecord::Migration
  def up
    create_table :guilds do |t|
      t.column :name, :string
      t.column :description, :text
      t.timestamps
    end

    create_table :guild_ownerships do |t|
      t.references :user
      t.references :guild
    end

    create_table :guild_users do |t|
      t.references :user
      t.references :guild
    end

    add_index :guild_ownerships, [:guild_id, :user_id], unique: true
    add_index :guild_users, [:guild_id, :user_id], unique: true
  end

  def down
    drop_table :guild_ownerships
    drop_table :guild_users
    drop_table :guilds
  end
end
