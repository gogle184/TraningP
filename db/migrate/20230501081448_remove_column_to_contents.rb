class RemoveColumnToContents < ActiveRecord::Migration[6.1]
  def change
    remove_column :contents, :about, :string
    remove_column :contents, :image, :string
  end
end
