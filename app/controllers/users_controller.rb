class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_user, only: :show

  def index
    @users = User.paginate page: params[:page], per_page: Settings.user.pages
  end

  def show
  end

  private
  def set_user
    @user = User.find params[:id]
  end
end
