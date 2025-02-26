json.extract! transaction, :id, :transaction_date, :notes, :total_amount_excl_vat, :total_amount_incl_vat, :company_id, :customer_id, :user_id, :created_at, :updated_at
json.url transaction_url(transaction, format: :json)
