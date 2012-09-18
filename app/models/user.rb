class User < ActiveRecord::Base
  use_connection_ninja(:ada_database)

  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :token_authenticatable, :authentication_keys => [:login]

  attr_accessor :login
  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :player_name, :password, :password_confirmation, :remember_me, :authentication_token

  before_create :update_control_group
  before_save :ensure_authentication_token
  before_validation :set_email_from_player_name, :on => :create


  def self.find_for_database_authentication(warden_conditions)
    conditions = warden_conditions.dup
    login = conditions.delete(:login)
    where(conditions).where(["lower(player_name) = :login OR lower(email) = :login", login: login.strip.downcase]).first
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

  def set_email_from_player_name
    return if self.email.present?
    return if self.player_name.blank?

    self.email = self.player_name + "@stu.de.nt"
  end
end
