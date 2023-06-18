class AddUniqueConstraintToAdminProjectId < ActiveRecord::Migration[6.1]
  def change
    add_index :admins, :project_id, unique: true
  end
end
