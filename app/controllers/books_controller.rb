class BooksController < ApplicationController
  before_action :authenticate_user!
  before_action :set_book, only: :show

  def index
    @categories = Category.all
    @search = Book.ransack params[:query]
    @books = @search.result(distinct: true)
                    .paginate page: params[:page],
                              per_page: Settings.admin.books.pages
  end

  def show
    @review = @book.reviews.build
  end

  private
  def set_book
    @book = Book.find params[:id]
  end
end
