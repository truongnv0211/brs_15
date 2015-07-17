class Relationship < ActiveRecord::Base
  include ActivitiesModel

  belongs_to :follower, class_name: "User"
  belongs_to :followed, class_name: "User"

  validates :follower_id, presence: true
  validates :followed_id, presence: true

  after_create {create_activity :follow, self.followed_id, self.follower_id}
  before_destroy {create_activity :unfollow, self.followed_id, self.follower_id}

end
