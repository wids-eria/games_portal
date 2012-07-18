class User < ActiveRecord::Base
  use_connection_ninja(:ada_database)

  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :token_authenticatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me, :authentication_token

  before_create :update_control_group
  before_save :ensure_authentication_token
  #before_validation_on_create :check_and_make_email_valid
  before_validation :check_and_make_email_valid, :on => :create
 
  def self.find_for_database_authentication(warden_conditions)
    conditions = warden_conditions.dup
    login = conditions.delete(:email)
    where(conditions).where(["lower(email) = :username OR lower(email) = :email", { :email => login.strip.downcase, :username => login.strip.downcase+'@stu.de.nt' }]).first
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

  def check_and_make_email_valid
    if not self.email.include?('@')
      self.email = self.email + '@stu.de.nt'
      puts self.email
    end
  end
end
