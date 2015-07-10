class Admin::BooksController < ApplicationController
  before_action :set_book, except: [:index, :new, :create]
  before_action :required_admin

  def index
    @books = Book.paginate page: params[:page], per_page: Settings.admin.books.pages
  end

  def show
  end

  def new
    @book = Book.new
  end

  def create
    @book = Book.new book_params
    if @book.save
      flash[:success] = t "admin.success_created_book"
      redirect_to [:admin, :books]
    else
      render "new"
    end
  end

  def edit
  end

  def update
    if @book.update book_params
      flash[:success] = t "admin.success_updated_book"
      redirect_to [:admin, :books]
    else
      render "edit"
    end
  end

  def destroy
    if @book.destroy
      flash[:success] = t "admin.success_destroyed_book"
    else
      flash[:danger] = t "admin.unsuccess_destroyed_book"
    end
    redirect_to [:admin, :books]
  end

  private
  def set_book
    @book = Book.find params[:id]
  end

  def book_params
    params.require(:book).permit :title, :publish_date, :author, :number_page,
      :rate, :content, :picture, :category_id
  end
end
