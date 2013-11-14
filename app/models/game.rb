class Game < ActiveRecord::Base
  attr_accessible :name,:path,:description,:image

  has_attached_file :image, :default_url => "/images/:style/missing.png"
  has_one :survey

  #@todo add validation that the path is url friendly
  validates_uniqueness_of :name,:path
  validates_presence_of :name,:path,:description
  validates :image, attachment_presence: true, presence: true
end
