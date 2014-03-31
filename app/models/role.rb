class Role < ActiveRecord::Base
  db_magic connection: :adage

  has_many :assignments
  has_and_belongs_to_many :users

  attr_accessible :name, :type, :game, :user_ids
end
