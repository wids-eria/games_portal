class AddAuthTokenToUser < ActiveRecord::Migration
  def up
    add_column :users, :token, :string
  end

  def remove
    remove_column :users, :token
  end
end
