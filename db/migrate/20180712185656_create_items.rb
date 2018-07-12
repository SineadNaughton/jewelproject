class CreateItems < ActiveRecord::Migration[5.2]
  def change
    create_table :items do |t|
      t.string :title
      t.text :description
      t.decimal :price
      t.string :image_url
      t.string :category
      t.string :material
      t.string :collection
      t.integer :quantity_instock
      t.integer :quantity_sold

      t.timestamps
    end
  end
end
