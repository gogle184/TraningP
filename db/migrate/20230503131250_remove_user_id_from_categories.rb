class RemoveUserIdFromCategories < ActiveRecord::Migration[6.1]
  def change
    remove_column :categories, :user_id, :integer
  end
end
