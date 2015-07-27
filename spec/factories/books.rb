FactoryGirl.define do
  sequence(:title) {|n| "Book Serial #{n}"}
  sequence(:author) {|n| "Author #{n}"}
  factory :book do
    title
    author
    publish_date "2015-05-05"
    number_page 10
  end
end
