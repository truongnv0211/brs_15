class Reading < ActiveRecord::Base
  include ActivitiesModel

  enum status: [:unread, :reading, :readed]
  after_initialize :default_status, if: :new_record?
  after_create {create_activity :read, self.book.id, self.user.id}

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
end
