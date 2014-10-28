class HasPlayed < Achievement
  before_create :set_default_values

  def set_default_values
    self.game_id = Game.find_by_name("Econauts").id
  end

  #Method to query adage data and check the achievement conditions
  def check_progress
    if self.can_check_progress
      on_db :adage do
        self.completed =  !AdaData.with_game(self.name).where(user_id: self.user_id).last.nil?
        self.save
      end
    end
    return self.completed
  end

  def name
    "Has Plsssayed Econauts"
  end

  def description
    "Has Plsssayed Econauts"
  end

end