class CreateProducts < ActiveRecord::Migration[5.2]
  def change

    # Add products table
    create_table :products do |t|
      t.string :name, null: false
      t.text :description, null: false
      t.integer :category_id, null: false
      t.decimal :price, null: false
      t.integer :quantity, null: false
      t.boolean :is_active, null: false, default: true
      t.timestamps
    end

    add_index :products, :category_id

    # Add categories table
    create_table :categories do |t|
      t.string :name, null: false
    end

  end
end
