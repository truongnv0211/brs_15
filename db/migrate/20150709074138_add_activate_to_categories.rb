class AddActivateToCategories < ActiveRecord::Migration
  def change
    add_column :categories, :activate, :boolean, null: false, default: false
  end
end
