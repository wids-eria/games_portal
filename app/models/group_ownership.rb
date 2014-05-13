class GroupOwnership < ActiveRecord::Base
  db_magic connection: :adage
  belongs_to :group
  belongs_to :user
end