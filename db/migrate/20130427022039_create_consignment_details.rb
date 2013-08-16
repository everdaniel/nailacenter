class CreateConsignmentDetails < ActiveRecord::Migration
  def change
    create_table :consignment_details do |t|
      t.references :consignment
      t.references :product
      t.integer :quantity
      t.decimal :cost
      t.timestamps
    end

    add_index :consignment_details, :consignment_id
    add_index :consignment_details, :product_id
    add_index :consignment_details, [:consignment_id, :product_id]
  end
end