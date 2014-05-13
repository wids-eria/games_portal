class Game < ActiveRecord::Base
  attr_accessible :name,:path,:description,:image,:file,:lesson_plan,:cirriculum,:survey,:survey_attributes,:about,:localpath,:microsite,:external_download

  has_attached_file :image, :default_url => "/images/:style/missing.png"
  has_attached_file :file
  has_attached_file :lesson_plan
  has_attached_file :cirriculum

  has_one :survey
  accepts_nested_attributes_for :survey

  validates_uniqueness_of :name,:path
  validates_presence_of :name,:path,:description

  validates_attachment_presence :image
  validates_attachment :image, content_type: {:content_type => ['image/png','image/jpg','image/jpeg']}
  validates_attachment_content_type :file, content_type: ['application/x-shockwave-flash','application/octet-stream']

  def has_data(user)
    #return !AdaData.with_game(self.path).where(user_id: user.ada_id).last.nil?
    return !AdaData.with_game(self.path).last.nil?
  end

  def last_playtime(user)
    #return AdaData.with_game(self.path).where(user_id: user.ada_id).last.timestamp
    return AdaData.with_game(self.path).last.timestamp
  end

end