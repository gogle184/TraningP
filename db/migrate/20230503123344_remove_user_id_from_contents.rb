class RemoveUserIdFromContents < ActiveRecord::Migration[6.1]
  def change
    remove_column :contents, :user_id, :integer
  end
end
