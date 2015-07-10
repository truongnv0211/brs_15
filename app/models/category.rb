class Category < ActiveRecord::Base
  has_many :books, dependent: :destroy

  validates :name, presence: true, length: {minimum: Settings.number.short_miximum}
  validates :content, presence: true, length: {minimum: Settings.number.short_miximum}
end
