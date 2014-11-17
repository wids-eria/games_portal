class Guild < ActiveRecord::Base
  has_many :guild_ownerships
  has_many :guild_users
  has_many :owners, through: :guild_ownerships, source: :user
  has_many :members, through: :guild_users, source: :user, as: :members

  after_create :generatecode,:createforums

  attr_accessible :name,:code,:color,:icon

  validates :name, uniqueness: true, presence: true

  def color

  end
  def icon

  end
  def generatecode
    #Generate zoopass until there is no collision
    pass = ZooPass.generate(4)
    while Guild.find_by_code(pass)
      pass = ZooPass.generate(4)
    end
    self.code = pass
  end

  def createforums
    category = Forem::Category.create(name:self.name)

    games = ["Econauts","Virulent","Citizen Science"]
    games.each do |game|
      forum  = Forem::Forum.create(name: game, category_id: category.id,description: game)
      GuildForum.create(forem_forums_id:  forum.id, guild_id: self.id)
    end
  end
end
