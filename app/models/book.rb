class Book < ActiveRecord::Base
  belongs_to :category
  has_many :reviews, dependent: :destroy
  has_many :readings, dependent: :destroy
  has_many :favorites, dependent: :destroy

  validates :title, presence: true, length: {minimum: Settings.admin.books.min_title_length,
    message: I18n.t("admin.validate_title", min: Settings.admin.books.min_title_length)
  }
  validates :author, presence: true
  validates :number_page, presence: true, numericality: {
    greater_than: Settings.admin.books.min_number_page,
    less_than_or_equal_to: Settings.admin.books.max_number_page
  }

  mount_uploader :picture, PictureUploader

  scope :un_favorite, ->user{where("id NOT IN (SELECT book_id FROM favorites WHERE user_id = ?)", user.id)}
  scope :suggest_un_favorite_books, ->user{Book.un_favorite(user).order("random()")
                                               .limit(Settings.favorite.books
                                               .suggest_un_favorite_books)}
  def picture_url
    return Settings.admin.books.picture_default_2 unless picture.present?
    picture.url
  end
end
