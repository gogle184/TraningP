class AddColumnVideoToContents < ActiveRecord::Migration[6.1]
  def change
    add_column :contents, :video, :string
  end
end
