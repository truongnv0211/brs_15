class Reading < ActiveRecord::Base
  enum status: Settings.reading_status
  after_initialize :default_status, if: :new_record?
  after_create :activity_read

  belongs_to :book
  belongs_to :user

  def default_status
    self.status ||= :reading
  end

  class << self
    def add_book params: {}
      reading = Reading.find_or_initialize_by user_id: params[:user_id],
                                              book_id: params[:book_id]
      reading.update_attributes status: params[:status]
      reading
    end
  end

  private
  def activity_read
    Activity.create action: "read|#{self.book.id}|", user_id: self.user.id
  end
end
