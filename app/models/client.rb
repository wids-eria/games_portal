class Client < ActiveRecord::Base
  db_magic connection: :adage

  before_create :generate_tokens
  belongs_to :implementation

  attr_accessible :implementation, :name, :app_token, :app_secret
  validates_uniqueness_of :app_token
  validates_uniqueness_of :app_secret

  def generate_tokens
    if implementation != nil
      self.app_token = implementation.name + '_' + SecureRandom.hex(16)
    else
      self.app_token = name + '_' + SecureRandom.hex(16)
    end
    self.app_secret = SecureRandom.hex(32)
  end

  def reset_secret
    self.app_secret = SecureRandom.hex(32)
  end

end
