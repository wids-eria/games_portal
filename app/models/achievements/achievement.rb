class Achievement < ActiveRecord::Base
  validates_uniqueness_of :type, scope: [:user_id, :game_id]

  belongs_to :user
  belongs_to :game


  attr_accessible :name, :description, :last_queried, :completed, :last_result

  def can_check_progress
    #checks to make sure the achivements conditions should be queried

    #make sure achivement isn't already completed
    unless self.completed
      unless self.last_queried.nil?
        #Only allow a query every minute
        if Time.now - self.last_queried < 5
          return false
        end
      end
      self.last_queried = Time.now
      self.save
      return true
    end

    return false
  end
end