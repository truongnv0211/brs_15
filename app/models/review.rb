class Review < ActiveRecord::Base
  belongs_to :book
  belongs_to :user
  has_many :comments, dependent: :destroy

  after_create :set_avarage_rating

  private
  def set_avarage_rating
    rate = reviews.avarage :rating
    book.rate = rate if rate
  end
end
