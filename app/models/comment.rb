class Comment < ActiveRecord::Base
  belongs_to :review
  belongs_to :user

  after_create :activity_comment

  def activity_comment
    Activity.create! action_type: :comment, action_target: self.id, user_id: self.user.id
  end
end
