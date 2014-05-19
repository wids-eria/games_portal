class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new # guest user
    cannot :read, Game

    if user.id
      can :read, Game
      unless user.has_role(:teacher) || user.has_role(:developer)
        can :resource, Game
      end

      if user.has_role(:teacher) || user.has_role(:researcher)
        can [:show,:create], Group
      end

      if user.admin?
        can :manage, :all
      end
    end
  end
end