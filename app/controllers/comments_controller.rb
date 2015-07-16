class CommentsController < ApplicationController
  before_action :set_comment, only: [:update, :destroy]

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

  def update
    if @comment.update_attributes comment_params
      respond_to do |format|
        format.json {respond_with_bip(@comment)}
        format.html {redirect_to :back}
      end
    end
  end

  def destroy
    if @comment.destroy
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

  def set_comment
    @comment = Comment.find params[:id]
  end
end
