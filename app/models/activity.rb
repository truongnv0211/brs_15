class Activity < ActiveRecord::Base
  enum action_type: Settings.activity_type_list

  belongs_to :user
  has_many :likes, dependent: :destroy

  def translate
    self.send "translate_" + self.action_type
  end

  def translate_favorite
    book = Book.find self.action_target rescue nil
    book ? I18n.t("activities.translate.favorite", name: self.user.name, title: book.title)
      : I18n.t("activities.translate.favorite_nil", name: self.user.name, id: self.action_target)
  end

  def translate_comment
    comment = Comment.find self.action_target rescue nil
    comment ? I18n.t("activities.translate.comment",
      name: self.user.name, title: comment.review.book.title)
        : I18n.t("activities.translate.comment_nil", name: self.user.name, id: self.action_target)
  end

  def translate_read
    read = Reading.find self.action_target rescue nil
    read ? I18n.t("activities.translate.read", name: self.user.name, title: read.book.title)
      : I18n.t("activities.translate.read_nil", name: self.user.name, id: self.action_target)
  end

  def translate_follow
    follow = User.findself.action_target rescue nil
    follow ? I18n.t("activities.translate.follow", name: self.user.name, follow_name: follow.name)
      : I18n.t("activities.translate.follow_nil", name: self.user.name, id: self.action_target)
  end

  def translate_unfollow
    unfollow = User.find self.action_target rescue nil
    unfollow ? I18n.t("activities.translate.unfollow", name: self.user.name, unfollow_name: unfollow.name)
      : I18n.t("activities.translate.unfollow_nil", name: self.user.name, id: self.action_target)
  end

  def translate_review
    review = Review.find self.action_target rescue nil
    review ? I18n.t("activities.translate.review", name: self.user.name, title: review.book.title)
      : I18n.t("activities.translate.review_nil", name: self.user.name, id: self.action_target)
  end
end
