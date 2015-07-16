class Admin::RequestsController < ApplicationController
  load_and_authorize_resource

  def index
    @requests = Request.paginate page: params[:page],
                                 per_page: Settings.number.per_page
  end

  def show
  end

  def edit
  end

  def update
    respond_to do |format|
      if @request.update_attributes request_params
        format.html {redirect_to [:admin, @request], notice: t("requests.update_request")}
      end
    end
  end

  def batch_update
    if Request.batch_update data_map: batch_update_params
      flash[:success] = t "requests.update_request"
    else
      flash[:alert] = t "requests.update_error"
    end
    redirect_to :back
  end

  private

  def request_params
    params.require(:request).permit :book_name, :author, :description, :status
  end

  def batch_update_params
    params.require :requests
  end
end
