class AddColumnToContents < ActiveRecord::Migration[6.1]
  def change
    add_column :contents, :image, :string
  end
end
