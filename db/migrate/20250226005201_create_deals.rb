class CreateDeals < ActiveRecord::Migration[6.1]
  def change
    create_table :deals do |t|
      t.references :item, null: false, foreign_key: true
      t.references :transaction, null: false, foreign_key: true
      t.integer :quantity
      t.decimal :price
      t.decimal :vat_rate
      t.decimal :total_excl_vat
      t.decimal :total_incl_vat

      t.timestamps
    end
  end
end
