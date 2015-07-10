class Admin::UsersController < ApplicationController
  before_action :required_admin
  before_action :set_user, except: [:index, :new, :create]

  def index
    @users = User.paginate page: params[:page],
      per_page: Settings.number.user_per_page
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new user_params
    if @user.save
      flash[:success] = t "admin-user.create-success"
      redirect_to admin_users_path
    else
      render "new"
    end
  end

  def destroy
    if @user.destroy
      flash[:success] = t "admin-user.delete-success"
    else
      flash[:danger] = t "admin-user.delete-unsuccess"
    end
    redirect_to admin_users_path
  end

  private
  def set_user
    @user = User.find params[:id]
  end

  def user_params
    params.require(:user).permit :name, :email, :password, :password_confirmation
  end
end
