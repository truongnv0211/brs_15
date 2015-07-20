namespace :request do
  task clean_accepted: :environment do
    puts "Clean accepted requests started @ #{Time.now}"
    accepted_requests = Request.accepted
    if ENV["RUN"] == "true"
      accepted_requests.destroy_all
    else
      accepted_requests.each do |request|
        puts "#{request.book_name}\t#{request.author}"
      end
    end
    puts "Clean accepted requests finished @ #{Time.now}"
  end
end
