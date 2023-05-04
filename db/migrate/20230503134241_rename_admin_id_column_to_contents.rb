class RenameAdminIdColumnToContents < ActiveRecord::Migration[6.1]
  def change
    rename_column :contents, :admin_id, :project_id
  end
end
