class CreateTransactions < ActiveRecord::Migration[6.1]
  def change
    create_table :transactions do |t|
      t.date :transaction_date
      t.text :notes
      t.decimal :total_amount_excl_vat
      t.decimal :total_amount_incl_vat
      t.references :company, null: false, foreign_key: true
      t.references :customer, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
