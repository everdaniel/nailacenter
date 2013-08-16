class CreateSuppliers < ActiveRecord::Migration
  def change
    create_table :suppliers do |t|
      t.string :short_name
      t.string :name
      t.text :description
      t.timestamps
    end
    add_index :suppliers, :short_name, unique: true
  end
end