class CreateStocks < ActiveRecord::Migration
  def change
    create_table :stocks do |t|
      t.integer :product_id
      t.decimal :cost
      t.decimal :price
      t.decimal :quantity

      t.timestamps
    end

    add_index :stocks, :product_id
    add_index :stocks, [:product_id, :cost]
  end
end
