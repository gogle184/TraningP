class AddUniqueIndexToContent < ActiveRecord::Migration[6.1]
  def change
    add_index :contents, [:admin_id, :title], unique: true
    add_index :contents, [:admin_id, :description], unique: true
  end
end
