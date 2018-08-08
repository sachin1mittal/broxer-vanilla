class CreatePaymentTransactions < ActiveRecord::Migration[5.1]
  def change
    create_table :payment_transactions do |t|
      t.references :order, index: true
      t.references :user, index: true
      t.string :gateway
      t.string :gateway_reference_number
      t.string :reference_number
      t.integer :order_amount
      t.decimal :transaction_charges
      t.decimal :commission_charges
      t.decimal :currency_conversion_charges
      t.decimal :other_charges
      t.decimal :amount
      t.string :mode
      t.string :currency
      t.string :transaction_type
      t.string :status
      t.string :invoice_number
      t.timestamps null: false
    end
  end
end
