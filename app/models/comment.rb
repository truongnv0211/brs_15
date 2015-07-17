class Comment < ActiveRecord::Base
  include ActivitiesModel

  belongs_to :review
  belongs_to :user

  after_create {create_activity :comment, self.id, self.user.id}
end
