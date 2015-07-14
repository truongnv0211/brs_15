class BooksController < ApplicationController
  before_action :set_search_params, only: :index
  before_action :authenticate_user!
  before_action :set_book, only: :show

  def index
    @categories = Category.all
    books = params[:favorite].present? ? current_user.favorited_books : Book.all
    @search = books.ransack params[:query]
    @books = @search.result(distinct: true)
                    .paginate page: params[:page],
                              per_page: Settings.admin.books.pages
  end

  def show
    @reviews = @book.reviews.includes :user, :comments
    @comment = current_user.comments.build
  end

  private
  def set_search_params
    return unless params[:query]
    rate = params[:query][:rate].to_i
    params[:query].delete :rate

    case rate
    when 1..4
      params[:query].merge!({rate_gteq: rate, rate_lt: rate + 1})
    when 5
      params[:query].merge!({rate_eq: rate})
    end
  end

  def set_book
    @book = Book.find params[:id]
  end
end
