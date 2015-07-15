class Reading < ActiveRecord::Base
  enum status: Settings.reading_status
  after_initialize :default_status, if: :new_record?

  belongs_to :book
  belongs_to :user

  def default_status
    self.status ||= :reading
  end
end
