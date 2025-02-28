class CreateTransactionRecordSummaries < ActiveRecord::Migration[6.1]
  def change
    create_table :transaction_record_summaries do |t|
      t.string :summary_type
      t.references :company, null: false, foreign_key: true
      t.references :customer, null: false, foreign_key: true
      t.references :item, null: false, foreign_key: true
      t.date :start_date
      t.date :end_date

      t.timestamps
    end
  end
end
