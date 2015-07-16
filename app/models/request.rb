class Request < ActiveRecord::Base
  belongs_to :user

  enum status: Settings.roles_status

  validates :book_name, presence: true
  validates :author, presence: true

  class << self
    def batch_update data_map: []
      update data_map.keys, data_map.values
    end
  end
end
