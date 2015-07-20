class LikesController < ApplicationController
  before_action :authenticate_user!
  before_action :find_activity

  def create
    @like = Like.new user_id: current_user.id, activity_id: @activity.id
    if @like.save
      respond_to do |format|
        format.js
      end
    end
  end

  def destroy
    @like = Like.find_by id: params[:id]
    if @like.destroy
      respond_to do |format|
        format.js
      end
    end
  end

  private
  def find_activity
    @activity = Activity.find_by id: params[:activity_id]
  end
end
