class AddUserToInventory < ActiveRecord::Migration[5.1]
  def change
    add_reference :inventories, :user, foreign_key: true
  end
end
