class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new # guest user
    cannot [:new,:create,:update], Game
    can :read, Game

    if user.id
      if user.has_role(:teacher) || user.has_role(:researcher) || user.has_role(:developer) || user.admin?
        can :resource, Game
      end

      if user.has_role(:teacher) || user.has_role(:researcher)
        can [:show,:create], Group
      end

      if user.admin? || user.has_role(:admin)
        can :manage, :all
      end
    end
  end
end