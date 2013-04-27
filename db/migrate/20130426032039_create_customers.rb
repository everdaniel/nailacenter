class CreateCustomers < ActiveRecord::Migration
  def change
    create_table :customers do |t|
      t.string :code
      t.string :first_name
      t.string :last_name
      t.string :company_name
      t.string :phone
      t.string :mobile

      t.timestamps
    end
  end
end
