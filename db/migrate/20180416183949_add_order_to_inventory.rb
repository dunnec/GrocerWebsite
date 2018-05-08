class AddOrderToInventory < ActiveRecord::Migration[5.1]
  def change
    add_reference :inventories, :order, foreign_key: true
  end
end
