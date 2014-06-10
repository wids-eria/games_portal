class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new # guest user
    cannot :read, Game

    if user.id
      can :read, Game
      if user.has_role(:teacher) || user.has_role(:researcher) || user.has_role(:developer) || user.admin?
        can :resource, Game
      end

      if user.has_role(:teacher) || user.has_role(:researcher)
        can [:show,:create], Group
      end

      if user.admin? || user.has_role(:admin)?
        can :manage, :all
      end
    end
  end
end