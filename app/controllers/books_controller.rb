class BooksController < ApplicationController
  def index
    @books = Book.paginate page: params[:page], per_page: Settings.admin.books.pages
  end
end
