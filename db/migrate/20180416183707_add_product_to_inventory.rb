class AddProductToInventory < ActiveRecord::Migration[5.1]
  def change
    add_reference :inventories, :product, foreign_key: true
  end
end
