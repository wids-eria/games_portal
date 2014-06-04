class Attachment < ActiveRecord::Base
  belongs_to :game, inverse_of: :attachments
  as_enum :type, [:lessons,:cirriculum]
  has_attached_file :file
  scope :lessons, :conditions => {type_cd: 0}
  scope :cirriculum, :conditions => {type_cd: 1}

  validates_attachment_presence :file
  do_not_validate_attachment_file_type :file, content_type: ['application/x-shockwave-flash','application/octet-stream']
  validates :type, presence: true
  validates :description, presence: true

  attr_accessible :file, :description,:type

end