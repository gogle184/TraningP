class AddAdminIdToContents < ActiveRecord::Migration[6.1]
  def change
    add_column :contents, :admin_id, :string, null: false, default: ""
  end
end
