class GuildForum < ActiveRecord::Base
  belongs_to :forum, class_name: "Forem::Forum",foreign_key: "forem_forums_id"
  belongs_to :guild

  validates_presence_of :guild_id,:forem_forums_id

  def recent_post
    return self.forum.posts.last
  end

end