json.extract! item, :id, :title, :description, :price, :image_url, :category, :material, :collection, :quantity_instock, :quantity_sold, :created_at, :updated_at
json.url item_url(item, format: :json)
