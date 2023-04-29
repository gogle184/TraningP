class RenameAdminIdColumnTousers < ActiveRecord::Migration[6.1]
  def change
    rename_column :users, :adminId, :admin_id
  end
end
