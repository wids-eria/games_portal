class AddConsentToUser < ActiveRecord::Migration
  def change
    add_column :users, :consented, :boolean, :default => true

  end
end
