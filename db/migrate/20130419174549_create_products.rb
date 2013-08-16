class CreateProducts < ActiveRecord::Migration
  def change
    create_table :products do |t|
      t.string :sku
      t.string :short_name
      t.string :name
      t.text :description
      t.string :reference
      t.date :last_sale
      t.date :last_buy
      t.timestamps
    end

    add_index :products, :sku, unique: true
    add_index :products, :short_name, unique: true
  end
end