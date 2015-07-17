module ActivitiesModel
  def create_activity action_type, action_target_id, user_id
    Activity.create! action_type: action_type, action_target_id: action_target_id, user_id: user_id
  end

  def find_column object, str
    str.split(".").each {|st| object = object.send st}
    object
  end
end
