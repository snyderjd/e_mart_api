class CreateOrders < ActiveRecord::Migration[5.2]
  def change
    create_table :orders do |t|
      t.integer :user_id, null: false
      t.boolean :is_complete, null: false, default: false
      t.decimal :total_cost, null: false
      t.timestamps
    end

    add_index :orders, :user_id

    create_table :order_products do |t|
      t.integer :order_id, null: false
      t.integer :product_id, null: false
      t.timestamps
    end

    add_index :order_products, :order_id
    add_index :order_products, :product_id

  end
end
