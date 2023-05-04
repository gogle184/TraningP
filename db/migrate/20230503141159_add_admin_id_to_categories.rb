class AddAdminIdToCategories < ActiveRecord::Migration[6.1]
  def change
    add_column :categories, :admin_id, :integer
  end
end
