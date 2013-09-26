class Game < ActiveRecord::Base
  attr_accessible :name,:path

  validates_uniqueness_of :name,:path
  validates_presence_of :name,:path

  scope :exclude,lambda{|id| where('_id != ?', id)}
end
