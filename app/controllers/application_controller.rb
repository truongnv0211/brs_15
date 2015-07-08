class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  protected
  def after_sign_in_path_for resource
    current_user.admin? ? admin_root_path : root_path
  end

  def required_admin
    authenticate_user!
    redirect_to root_path unless current_user.admin?
  end
end
