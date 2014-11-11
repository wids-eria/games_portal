class CreateGuildForems < ActiveRecord::Migration
  def up
    create_table :guild_forums do |t|
      t.references :forem_forums
      t.references :guild
    end

    add_index :guild_forums, [:guild_id, :forem_forums_id], unique: true
  end

  def down
    drop_table :guild_forums
  end
end
