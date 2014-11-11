class GuildForum < ActiveRecord::Base
  belongs_to :forum, class_name: "Forem::Forum"
  belongs_to :guild

  validates_presence_of :guild_id,:forem_forums_id
end