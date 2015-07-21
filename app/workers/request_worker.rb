class RequestsWorker
  include Sidekiq::Worker
  sidekiq_options retry: false

  def perform request_id
    request = Request.find request_id
    UserMailer.email_accept_buy_book(request).deliver_now
  end
end
