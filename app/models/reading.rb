class Reading < ActiveRecord::Base
  enum status: Settings.reading_status
  after_initialize :default_status, if: :new_record?

  belongs_to :book
  belongs_to :user

  after_create :activity_read

  def default_status
    self.status ||= :reading
  end

  private
  def activity_read
    Activity.create action: "read|#{self.book.id}|", user_id: self.user.id
  end
end
