class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new # guest user

    cannot :read, :game

    if user.id and user.admin?

      unless user.has_role(:teacher) || user.has_role(:developer)
        can :landing, Game
      end

      if user.admin?
        can :manage, :all
      end
    end
  end
end