class CreateAttatchmentTable < ActiveRecord::Migration
  def self.up
    create_table :attachments do |t|
      t.references :game
      t.string :description
      t.attachment :file
      t.integer :type_cd
      t.timestamps
    end
  end

  def self.down
    drop_table :attachments
  end
end
