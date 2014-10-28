class GuildOwnership < ActiveRecord::Base
  belongs_to :guild
  belongs_to :user
end