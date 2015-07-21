class Request < ActiveRecord::Base
  belongs_to :user

  enum status: Settings.roles_status

  validates :book_name, presence: true
  validates :author, presence: true

  after_update :send_to_email_queue

  scope :accepted, -> (target_date: 7.days.ago) {
    where(status: 1,
          updated_at: target_date.at_beginning_of_day..target_date.at_end_of_day)
  }

  class << self
    def batch_update data_map: []
      update data_map.keys, data_map.values
    end
  end

  private
  def send_to_email_queue
    RequestsWorker.perform_async self.id if self.status == "accepted"
  end
end
