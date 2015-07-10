# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
10.times do |n|
  Category.create!(name: "Category" + n.to_s)
end

100.times do |n|
  Book.create!(title: "Book" + n.to_s,
    publish_date: "2015/07/08",
    author: "Author" + n.to_s,
    number_page: n,
    content: "Content",
    category_id: 1
  )
end
