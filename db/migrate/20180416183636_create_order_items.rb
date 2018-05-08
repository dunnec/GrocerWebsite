class CreateOrderItems < ActiveRecord::Migration[5.1]
  def change
    create_table :order_items do |t|
      t.integer :quantity
      t.decimal :subtotal, scale: 2

      t.timestamps
    end
  end
end
