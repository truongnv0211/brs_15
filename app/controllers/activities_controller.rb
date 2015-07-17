class ActivitiesController < ApplicationController
  before_action :authenticate_user!

  def index
    @user = User.find params[:user_id]
    @activities = @user.activities.paginate page: params[:page],
      per_page: Settings.activities.pages
  end
end
