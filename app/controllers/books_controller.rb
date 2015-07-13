class BooksController < ApplicationController
  def index
    @categories = Category.all
    @search = Book.ransack params[:query]
    @books = @search.result(distinct: true)
                    .paginate page: params[:page],
                              per_page: Settings.admin.books.pages
  end
end
