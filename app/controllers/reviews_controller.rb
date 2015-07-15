class ReviewsController < ApplicationController
  before_action :set_review, only: [:update, :destroy]

  def create
    @new_review = current_user.reviews.build review_params
    if @new_review.save
      flash[:success] = t "book.review-create-success"
    else
      flash[:danger] = t "book.review-create-failed"
    end
    redirect_to book_path @new_review.book
  end

  def update
    if @review.update_attributes review_params
      flash[:success] = t "book.review-update-success"
    else
      flash[:danger] = t "book.review-update-failed"
    end
    redirect_to book_path @review.book
  end

  def destroy
    if @review.destroy
      respond_to do |format|
        format.js
      end
    end
  end

  private
  def review_params
    params.require(:review).permit :book_id, :user_id, :subject, :content, :rating
  end

  def set_review
    @review = Review.find params[:id]
  end
end
