class FavoritesController < ApplicationController
  before_action :authenticate_user!

  def index
    @user = User.find params[:user_id]
    @books = @user.favorited_books
                  .paginate page: params[:page],
                            per_page: Settings.favorite.books.pages
    @suggest_books = Book.suggest_un_favorite_books @user
  end

  def create
    @user = User.find params[:user_id]
    @book = Book.find params[:book_id]
    respond_to do |format|
      format.js if @user.add_favorite @book
    end
  end

  def destroy
    @favorite = Favorite.find params[:id]
    @book = @favorite.book
    respond_to do |format|
      format.js if @favorite.destroy
    end
  end
end
