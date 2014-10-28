class Guild < ActiveRecord::Base
  has_many :guild_ownerships
  has_many :guild_users
  has_many :owners, through: :guild_ownerships, source: :user
  has_many :members, through: :guild_users, source: :user, as: :members

  before_create :generatecode

  attr_accessible :name, :description,:code

  validates :name, uniqueness: true, presence: true
  validates :description, presence: true

  def generatecode
    #Generate zoopass until there is no collision
    pass = ZooPass.generate(4)
    while Guild.find_by_code(pass)
      pass = ZooPass.generate(4)
    end
    self.code = pass
  end
end
