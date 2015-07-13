# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
10.times do |n|
  Category.create!(name: "Category" + n.to_s, content: "Content")
end

100.times do |n|
  Book.create!(title: "BookBook" + n.to_s,
    publish_date: "2015/07/08",
    author: "Author" + n.to_s,
    number_page: n + 100,
    content: "Content content",
    category_id: 1
  )
end
