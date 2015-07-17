class CreateActivities < ActiveRecord::Migration
  def change
    create_table :activities do |t|
      t.integer :action_type
      t.integer :action_target
      t.integer :user_id

      t.timestamps null: false
    end
  end
end
