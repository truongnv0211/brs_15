class CommentsController < ApplicationController
  def create
    @comment = current_user.comments.build comment_params
    if @comment.save
      flash[:success] = t "books.comment-success"
      respond_to do |format|
        format.js
        format.html {redirect_to :back}
      end
    end
  end

  private
  def comment_params
    params.require(:comment).permit :content, :review_id
  end
end
