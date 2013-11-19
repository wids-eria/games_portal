class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new # guest user

    can :read, :game

    if user.admin?
        can :manage, :all
    end
  end
end