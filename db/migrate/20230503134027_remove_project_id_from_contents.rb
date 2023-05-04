class RemoveProjectIdFromContents < ActiveRecord::Migration[6.1]
  def change
    remove_column :contents, :project_id, :string
  end
end
