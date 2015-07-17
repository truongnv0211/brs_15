class Favorite < ActiveRecord::Base
  include ActivitiesModel
  belongs_to :book

  after_create {create_activity :favorite, self.book_id, self.user_id}
end
