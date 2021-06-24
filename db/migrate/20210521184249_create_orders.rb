class CreateOrders < ActiveRecord::Migration[5.0]
  def change
    create_table :orders do |t|
      t.belongs_to :costumer, index: true, foreign_key: true
      t.string :product_name
      t.integer :product_count
      t.references :customer, foreign_key: true
      t.timestamps
    end
  end
end
