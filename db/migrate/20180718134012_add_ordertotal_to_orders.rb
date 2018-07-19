class AddOrdertotalToOrders < ActiveRecord::Migration[5.2]
  def change
    add_column :orders, :order_total, :decimal
  end
end
