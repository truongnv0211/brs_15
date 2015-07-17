class Ability
  include CanCan::Ability

  def initialize user
    user ||= User.new
    if user.admin?
      can :manage, :all
    elsif user.normal?
      can [:update, :destroy], [Review, Comment], user_id: user.id
      can [:create, :destroy], Request, user_id: user.id
      can [:edit, :update], User, id: user.id
      can [:show, :index], User
    end
  end
end
