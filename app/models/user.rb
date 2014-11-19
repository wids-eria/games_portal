class User < ActiveRecord::Base

  #include these devise modules to preserve the devise routes
  devise :registerable, :token_authenticatable, :authentication_keys => [:login]

  has_many :achievements, :order => 'game_id DESC'
  has_many :guild_ownerships
  has_many :guild_users
  has_many :owned_guilds, through: :guild_ownerships, source: :guild
  has_many :guilds, through: :guild_users, source: :guild
  has_many :group_ownerships
  has_many :owned_groups, through: :group_ownerships, source: :group, :uniq => true
  has_and_belongs_to_many :roles
  has_and_belongs_to_many :groups

  attr_accessor :login

  attr_accessible :email, :player_name, :token, :guest, :auth_token
  validates_presence_of :player_name
  validates_uniqueness_of :player_name

  def forem_name
    player_name
  end

  def name
    player_name
  end

  def email
    ""
  end

  def forem_email
    email
  end

  def self.find_for_database_authentication(warden_conditions)
    conditions = warden_conditions.dup
    login = conditions.delete(:login)
    where(conditions).where(["lower(player_name) = :login OR lower(email) = :login", login: login.strip.downcase]).first
  end

  def self.create_from_adage(user)
    unless User.find_by_id(user[:id])
      u = User.new(player_name: user[:player_name])
      u.id = user[:id]
      u.save
      return u
    else
      return User.find_by_id(user[:id])
    end
  end

  def self.create_from_session(session)
    unless User.find_by_id(session[:id])
      u = User.new(player_name: session[:player_name], token: session[:token], auth_token: session[:auth])
      u.id = session[:id]
      return u.save
    else
      user =  User.find_by_id(session[:id])

      if user.token.nil?
        user[:token] = session[:token]
        user[:auth_token] = session[:auth]
        user.save
      end
    end
  end

  def self.create_guest

  end

  def can_view_user(other)
    puts other.to_json
    puts self.to_json
    if other.id == self.id
      return true
    end

    self.owned_guilds.each do |guild|
      guild.members.each do |temp|
        if other == temp
          return true
        end
      end
    end
    false
  end

  def update_achievements
    if Achievement.descendants.size != self.achievements.count
      temp = self.achievements.all
      Achievement.descendants.each do |achievement|
        has_achievement = false
        temp.each do |current|
          if current == achievement
            has_achievement = true
            temp.delete(current)
            break
          end
        end

        unless has_achievement
          a = achievement.new
          a.user_id = self.id
        #  a.save
        end
      end
    end
  end

  def has_role(role)
    role = role.to_s.downcase
    for temp in roles do
      if temp.name.to_s.downcase == role
        return true
      end
    end
    false
  end

  #This is an override for Forem to check if a user is allowed to view a forum
  def can_read_forem_forum?(forum)
    GuildForum.where({forem_forums_id:  forum.id, guild_id: self.guilds}).any?
  end

  def can_read_forem_category?(category)
    guild =  Guild.find_by_name(category.name)
    unless guild.nil?
      return GuildForum.where({forem_forums_id: category.forums, guild_id: guild.id}).any?
    end
    false
  end
end
