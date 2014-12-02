class Code
  include ActiveModel::Validations
  include ActiveModel::Conversion
  include ActiveModel::AttributeMethods
  extend ActiveModel::Naming

  attr_accessor :name
  validates_presence_of :name

  def initialize(attributes={})
    attributes.each do |name, value|
      self.public_send("#{name}=", value)
    end if attributes
  end

  def persisted?
    false
  end
end