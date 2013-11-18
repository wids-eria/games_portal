class Game < ActiveRecord::Base
  attr_accessible :name,:path,:description,:image,:file

  has_attached_file :image, :default_url => "/images/:style/missing.png"
  has_attached_file :file
  has_one :survey

  validates_uniqueness_of :name,:path
  validates_presence_of :name,:path,:description

  validates_attachment_presence :image,:file
  validates_attachment :image, content_type: {:content_type => ['image/png','image/jpg','image/jpeg']}
  validates_attachment_content_type :file, content_type: ['application/octet-stream','application/vnd.unity']


  before_validation :test

  def test
    puts :file.to_yaml

  end
end
