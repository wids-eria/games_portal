class User < ActiveRecord::Base
  #include these devise modules to preserve the devise routes
  devise :registerable, :token_authenticatable, :authentication_keys => [:login]

  has_and_belongs_to_many :roles
  attr_accessor :login
  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :player_name, :ada_id, :token, :guest, :auth_token
  attr_readonly :roles

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


end
