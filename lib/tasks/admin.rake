namespace :admin do
  task create: :environment do
    User.create! name: "Admin", email: "admin@brs.com",
      password: "password", role: :admin
  end
end
