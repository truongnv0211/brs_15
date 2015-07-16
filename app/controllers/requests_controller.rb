class RequestsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_requests, only: :destroy

  def index
    @user = current_user
    @requests = @user.requests.paginate page: params[:page],
                                      per_page: Settings.number.per_page
  end

  def create
    @request = Request.new request_params
    if @request.save
      respond_to do |format|
        format.js
        format.html {redirect_to :back}
      end
    end
  end

  def destroy
    @request.destroy
    respond_to do |format|
      format.html{redirect_to @request, notice: t("requests.destroy_success")}
      format.json
    end
  end

  private
  def set_requests
    @request = Request.find params[:id]
  end

  def request_params
    params.require(:request).permit :book_name, :author, :description, :user_id
  end
end
