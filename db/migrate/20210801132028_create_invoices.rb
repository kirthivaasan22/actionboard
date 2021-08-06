class CreateInvoices < ActiveRecord::Migration[6.0]

  def change
    create_table :invoices do |t|
      t.string :reference, null: false, limit: 191
      t.datetime :invoice_date, null: false
      t.string :customer, null: false, limit: 191
      t.string :brand_manager, null: false, limit: 191
      t.string :narration, null: false, limit: 191
      t.integer :amount, null: false
      t.integer :total_collection, default: 0, null: false
      t.integer :balance_due, null: false
      t.timestamps
    end

    add_index :invoices, :reference, unique: true
  end

end
