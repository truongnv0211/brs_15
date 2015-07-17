class AddIndexToReadings < ActiveRecord::Migration
  def change
    add_index :readings, [:user_id, :book_id], unique: true
  end
end
