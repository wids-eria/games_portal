class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new # guest user

    can :read, :game

    puts user.to_yaml
    puts "_-_-_--_-_-_-__"*10
    if user.admin?
        puts "ASD"*30
        can :manage, :all
    end
  end
end