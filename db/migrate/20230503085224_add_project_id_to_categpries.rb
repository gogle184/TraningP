class AddProjectIdToCategpries < ActiveRecord::Migration[6.1]
  def change
    add_column :categories, :project_id, :string
  end
end
