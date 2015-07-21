class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :find_user, only: [:show, :edit]
  load_and_authorize_resource

  def index
    @search = User.ransack params[:query]
    @user = @search.result distinct: true
    @users = @user.paginate page: params[:page], per_page: Settings.user.pages
  end

  def show
  end

  def edit
  end

  def update
    if @user.update_attributes user_params
      flash[:success] = t "user.success_update_profile"
    else
      flash[:danger] = t "user.unsuccess_update_profile"
    end
    redirect_to activities_path user_id: current_user.id
  end

  private
  def find_user
    @user = User.find params[:id]
  end

  def user_params
    params.require(:user).permit :name, :email, :password
  end
end
