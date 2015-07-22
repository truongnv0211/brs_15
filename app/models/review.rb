class Review < ActiveRecord::Base
  include ActivitiesModel

  belongs_to :book
  belongs_to :user
  has_many :comments, dependent: :destroy

  after_create {create_activity :review, self.id, self.user.id}
  after_save :set_avarage_rating
  after_destroy :set_avarage_rating
  after_commit :send_email_new_review, on: :create
  scope :order_reviews, ->{order created_at: :DESC}

  private
  def set_avarage_rating
    rate = self.book.reviews.average :rating
    book.rate = self.book.reviews.any? ? rate : 0
    book.save
  end

  def send_email_new_review
    ReviewsWorker.perform_async self.book.id
  end
end
