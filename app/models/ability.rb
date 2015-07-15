class Ability
  include CanCan::Ability

  def initialize user
    user ||= User.new
    if user.admin?
      can :manage, :all
    elsif user.user?
      can [:update, :destroy], [Review, Comment], user_id: user.id
    end
  end
end
