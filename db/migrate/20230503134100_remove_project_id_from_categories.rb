class RemoveProjectIdFromCategories < ActiveRecord::Migration[6.1]
  def change
    remove_column :categories, :project_id, :string
  end
end
