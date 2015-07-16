class RelationshipsController < ApplicationController
  before_action :authenticate_user!

  def index
    if Settings.follow_type.include? params[:type]
      @title = t params[:type]
      @user = User.find params[:id]
      @users = @user.send(params[:type]).paginate page: params[:page],
        per_page: Settings.number.user_per_page_2
    else
      redirect_to @user
    end
  end

  def create
    @user = User.find params[:followed_id]
    current_user.follow @user
    respond_to do |format|
      format.html {redirect_to @user}
      format.js
    end
  end

  def destroy
    @user = Relationship.find(params[:id]).followed
    current_user.unfollow @user
    respond_to do |format|
      format.html {redirect_to @user}
      format.js
    end
  end
end
