class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new # guest user
    cannot :read, Game

    if user.id
      can :read, Game
      can :profile, User, :id => user.id
      unless user.has_role(:teacher) || user.has_role(:developer)
        can :resource, Game
      end

      if user.admin?
        can :manage, :all
      end
      if user.has_role(:teacher)
        can [:show,:create], Group
        can :profile, User, :id => user.id



      end
    end
  end
end