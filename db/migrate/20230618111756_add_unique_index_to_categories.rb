class AddUniqueIndexToCategories < ActiveRecord::Migration[6.1]
  def change
    add_index :categories, [:admin_id, :title], unique: true
    add_index :categories, [:admin_id, :description], unique: true
  end
end
