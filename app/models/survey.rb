class Survey < ActiveRecord::Base

  belongs_to :game
  attr_accessible :url
end
