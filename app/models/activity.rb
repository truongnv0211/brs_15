class Activity < ActiveRecord::Base
  include ActivitiesModel
  enum action_type: [:favorite, :read, :review, :comment, :follow, :unfollow]

  belongs_to :user
  has_many :likes, dependent: :destroy

  def content_message
    object_target = Object.const_get((Settings.activity_translate[self.action_type]).class_name).
      find self.action_target_id rescue nil
    object_target ? I18n.t("activities.translate." + self.action_type,
      name: self.user.name,
      column: find_column(object_target, (Settings.activity_translate[self.action_type]).column))
        : I18n.t("activities.translate." + self.action_type + "_nil",
          name: self.user.name, id: self.action_target_id)
  end
end
