class ReadingsController < ApplicationController
  before_action :authenticate_user!
  before_action :find_reading, only: [:destroy, :update]
  before_action :find_book, only: [:create, :update]
  before_action :find_user, only: [:index, :create, :update]

  def index
    @user ||= current_user
    @reading_books = @user.reading_books
                          .paginate page: params[:page],
                                    per_page: Settings.admin.books.pages
  end

  def create
    @reading = Reading.add_book params: reading_params
    respond_to do |format|
      format.js {@reading.errors.any? ? render(:error) : render(:success)}
    end
  end

  def update
    respond_to do |format|
      format.js {@reading.update(reading_params) ? render(:success) : render(:error)}
    end
  end

  def destroy
    @book = @reading.book
    respond_to do |format|
      format.js {@reading.destroy  ? render(:success) : render(:error)}
    end
  end

  private
  def find_reading
    @reading = Reading.find params[:id]
  end

  def find_book
    @book = Book.find params[:book_id]
  end

  def find_user
    @user = User.find_by id: params[:user_id]
  end

  def reading_params
    params.permit :user_id, :book_id, :status
  end
end
