class Comment < ActiveRecord::Base
  include ActivitiesModel

  belongs_to :review
  belongs_to :user

  after_create {create_activity :comment, self.id, self.user.id}
  after_commit :send_mail_new_comment, on: :create

  private
  def send_mail_new_comment
    CommentsWorker.perform_async self.id
  end
end
