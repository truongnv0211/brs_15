class Favorite < ActiveRecord::Base
  include ActivitiesModel
  belongs_to :user
  belongs_to :book

  validates_uniqueness_of :user_id, scope: [:book_id]

  after_create {create_activity :favorite, self.book_id, self.user.id}
end
