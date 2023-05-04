class RenameAdminIdColumnToUsers < ActiveRecord::Migration[6.1]
  def change
    rename_column :users, :admin_id, :project_id
  end
end
