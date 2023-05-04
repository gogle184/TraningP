class AddAdminIdToContents < ActiveRecord::Migration[6.1]
  def change
    add_column :contents, :admin_id, :integer
  end
end
