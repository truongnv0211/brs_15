class ReviewsWorker
  include Sidekiq::Worker
  sidekiq_options retry: false

  def perform book_id
    list_review = Book.find(book_id).reviews
    last_user = list_review.last.user
    list_review.each do |review|
      UserMailer.email_notice_new_review(review, last_user).deliver_now
    end
  end
end
