FactoryGirl.define do
  sequence(:email) {|n| "dummy_email_#{n}@exacaca.com"}

  factory :user do
    password "123456"
    password_confirmation "123456"
    email
  end
end
