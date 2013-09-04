class User < ActiveRecord::Base

  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :confirmable, :lockable, :timeoutable and :omniauthable
  devise :registerable, :token_authenticatable, :authentication_keys => [:login]

  attr_accessor :login
  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :player_name, :ada_id, :token

  before_create :update_control_group
  validates_presence_of :token, :ada_id

  def self.find_for_database_authentication(warden_conditions)
    conditions = warden_conditions.dup
    login = conditions.delete(:login)
    where(conditions).where(["lower(player_name) = :login OR lower(email) = :login", login: login.strip.downcase]).first
  end

  def self.create_from_session(session)
    unless User.find_by_ada_id(session[:ada_id])
      return User.create(ada_id: session[:ada_id], player_name: session[:player_name], token: session[:token])
    end
  end

  private

  def update_control_group
    if self.control_group.nil?
      if rand() < 0.5
        self.control_group = false
      else
        self.control_group = true
      end
    end

    true
  end
end
