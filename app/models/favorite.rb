class Favorite < ActiveRecord::Base
  belongs_to :user
  belongs_to :book

  after_create :activity_favorite

  def activity_favorite
    Activity.create! action: "favorite|#{self.book.id}|", user_id: self.user.id
  end
end
