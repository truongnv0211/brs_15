class Request < ActiveRecord::Base
  belongs_to :user

  enum status: Settings.roles_status

  validates :book_name, presence: true
  validates :author, presence: true

end
