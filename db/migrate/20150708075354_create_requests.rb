class CreateRequests < ActiveRecord::Migration
  def change
    create_table :requests do |t|
      t.string :book_name
      t.string :author
      t.string :description
      t.string :user_id
      t.integer :status, default: 0

      t.timestamps null: false
    end
  end
end
