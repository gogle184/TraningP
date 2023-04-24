class CreateContents < ActiveRecord::Migration[6.1]
  def change
    create_table :contents do |t|
      t.string :title
      t.string :about
      t.integer :category_id
      t.string :image
      t.string :description

      t.timestamps
    end
  end
end
