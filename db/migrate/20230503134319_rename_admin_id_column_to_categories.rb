class RenameAdminIdColumnToCategories < ActiveRecord::Migration[6.1]
  def change
    rename_column :categories, :admin_id, :project_id
  end
end
