class Game < ActiveRecord::Base
  attr_accessible :name,:path,:description

  #@todo add validation that the path is url friendly
  validates_uniqueness_of :name,:path
  validates_presence_of :name,:path,:description

end
