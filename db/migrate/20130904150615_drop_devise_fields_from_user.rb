class DropDeviseFieldsFromUser < ActiveRecord::Migration
  def up
    ## Database authenticatable
    remove_column :users, :email
    remove_column :users, :encrypted_password

    ## Recoverable
    remove_column :users, :reset_password_token
    remove_column :users, :reset_password_sent_at

    ## Rememberable
    remove_column :users, :remember_created_at

    ## Trackable
    remove_column :users, :sign_in_count
    remove_column :users, :current_sign_in_at
    remove_column :users, :last_sign_in_at
    remove_column :users, :current_sign_in_ip
    remove_column :users, :last_sign_in_ip
  end

  def down
    ## Database authenticatable
    add_column :users, :email, :string
    add_column :users, :encrypted_password, :string

    ## Recoverable
    add_column :users, :reset_password_token, :string
    add_column :users, :reset_password_sent_at, :datetime

    ## Rememberable
    add_column :users, :remember_created_at, :datetime

    ## Trackable
    add_column :users, :sign_in_count, :integer
    add_column :users, :current_sign_in_at, :datetime
    add_column :users, :last_sign_in_at, :datetime
    add_column :users, :current_sign_in_ip, :string
    add_column :users, :last_sign_in_ip, :string
  end
end
