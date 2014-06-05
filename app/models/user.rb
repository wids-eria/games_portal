class User < ActiveRecord::Base

  #include these devise modules to preserve the devise routes
  devise :registerable, :token_authenticatable, :authentication_keys => [:login]

  attr_accessor :login
  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :player_name, :token, :guest, :auth_token

  validates_presence_of :player_name

  has_many :group_ownerships
  has_many :owned_groups, through: :group_ownerships, source: :group, :uniq => true
  has_and_belongs_to_many :roles
  has_and_belongs_to_many :groups

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
    Rails.logger.debug("[ [ [ " + other.id.to_s + "::" + self.id.to_s + "  ] ] ]")
    if other.id == self.id
      return true
    end

    self.owned_groups.each do |group|
      group.on_db(:adage).users.each do |temp|
        if other == temp
          return true
        end
      end
    end
    false
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
end
