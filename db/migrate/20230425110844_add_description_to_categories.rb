class AddDescriptionToCategories < ActiveRecord::Migration[6.1]
  def change
    add_column :categories, :description, :string
    rename_column :categories, :name, :title
  end
end
