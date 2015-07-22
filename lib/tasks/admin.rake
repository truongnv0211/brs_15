namespace :admin do
  def send_email
    puts "Sending email to admin..."
    UserMailer.email_admin_rating_books.deliver_now
    puts "Done! The next one will be send at the end of next month."
    end_of_next_month = Time.now.next_month.end_of_month
    self.delay(run_at: end_of_next_month - 1.hour).send_email
  end

  task create: :environment do
    User.create! name: "Admin", email: "admin@brs.com",
      password: "password", role: :admin
  end

  task monthly_rating_book_reminder: :environment do
    self.delay(run_at: Time.now.end_of_month - 1.hour).send_email
  end
end
