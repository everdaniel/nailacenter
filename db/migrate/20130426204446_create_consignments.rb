class CreateConsignments < ActiveRecord::Migration
  def change
    create_table :consignments do |t|
      t.integer :supplier_id
      t.string :name
      t.integer :status, :default => 1

      t.timestamps
    end

    add_index :consignments, :supplier_id
    add_index :consignments, :status
  end
end
