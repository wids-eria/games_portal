class User < ActiveRecord::Base
  #include these devise modules to preserve the devise routes
  devise :registerable, :token_authenticatable, :authentication_keys => [:login]

  attr_accessor :login
  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :player_name, :ada_id, :token, :guest, :auth_token

  validates_presence_of :token, :ada_id

  def self.find_for_database_authentication(warden_conditions)
    conditions = warden_conditions.dup
    login = conditions.delete(:login)
    where(conditions).where(["lower(player_name) = :login OR lower(email) = :login", login: login.strip.downcase]).first
  end

  def self.create_from_session(session)
    unless User.find_by_ada_id(session[:ada_id])
      return User.create(ada_id: session[:ada_id], player_name: session[:player_name], token: session[:token], auth_token: session[:auth])
    end
  end

  def self.create_guest

  end

  def roles
    #Does a query to get all the roles for a user, this is done via sql because you cannot use ada_id to join on with the rails ORM

    query = "SELECT roles.* FROM roles
    INNER JOIN roles_users ON roles.id = roles_users.role_id
    WHERE roles_users.user_id = " + self.ada_id.to_s

    return Role.on_db(:adage).find_by_sql(query)
  end

  def has_role(role)
    role = role.to_s.downcase + "role"
    for temp in roles do
      if temp.type.to_s.downcase == role
        return true
      end
    end
    false
  end
end
