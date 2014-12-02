class Guild < ActiveRecord::Base
  has_many :guild_ownerships
  has_many :guild_users
  has_many :owners, through: :guild_ownerships, source: :user
  has_many :members, through: :guild_users, source: :user, as: :members

  before_create :generatecode
  after_create :createforums

  attr_accessible :name,:code,:color,:icon,:class_name

  validates :name, uniqueness: true, presence: true
  validates :class_name, uniqueness: true, presence: true

  as_enum :color, [:pink,:green,:orange,:blue]
  as_enum :icon, [:swords,:swirl,:assignment]

  def generatecode
    #Generate zoopass until there is no collision
    pass = ZooPass.generate(4)
    while Guild.find_by_code(pass)
      pass = ZooPass.generate(4)
    end
    self.code = pass
    code = pass
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
