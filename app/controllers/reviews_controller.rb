class ReviewsController < ApplicationController
  def create
    @new_review = current_user.reviews.build review_params
    if @new_review.save
      flash[:success] = t "book.review-create-success"
    else
      flash[:danger] = t "book.review-create-fails"
    end
    redirect_to book_path @new_review.book
  end

  private
  def review_params
    params.require(:review).permit :book_id, :user_id, :subject, :content, :rating
  end
end
