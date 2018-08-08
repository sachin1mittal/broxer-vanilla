class CreateOrders < ActiveRecord::Migration[5.1]
  def change
    create_table :orders do |t|
      t.integer :buyer_id, index: true
      t.integer :seller_id, index: true
      t.string :reference_number
      t.text :description
      t.references :package, index: true
      t.integer :quantity
      t.integer :amount
      t.date :expected_completion_date
      t.integer :expected_delivery_time
      t.string :status
      t.string :payment_status
      t.timestamps null: false
    end
  end
end
