class ReadingsController < ApplicationController
  before_action :authenticate_user!
  before_action :find_reading, only: [:destroy, :update]
  before_action :find_user_book, only: [:create, :update]

  def create
    @reading = Reading.new reading_params
    respond_to do |format|
      @reading.save ? format.js {render :success} : format.js {render :error}
    end
  end

  def update
    respond_to do |format|
      @reading.update(reading_params) ? format.js {render :success} : format.js {render :error}
    end
  end

  def destroy
    @book = @reading.book
    respond_to do |format|
      @reading.destroy ? format.js {render :success} : format.js {render :error}
    end
  end

  private
  def find_reading
    @reading = Reading.find params[:id]
  end

  def find_user_book
    @user = User.find params[:user_id]
    @book = Book.find params[:book_id]
  end

  def reading_params
    params.permit :user_id, :book_id, :status
  end
end
