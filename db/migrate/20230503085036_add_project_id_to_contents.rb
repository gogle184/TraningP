class AddProjectIdToContents < ActiveRecord::Migration[6.1]
  def change
    add_column :contents, :project_id, :string
  end
end
