class CreateOrders < ActiveRecord::Migration[5.0]
  def change
    create_table :orders do |t|
      t.integer :user_id
      t.integer :total_price, defalut: 0
      t.string :shopping_name
      t.string :shopping_address
      t.string :billing_name
      t.string :billing_address
      t.timestamps
    end
  end
end
