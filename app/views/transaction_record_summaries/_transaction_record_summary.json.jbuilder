json.extract! transaction_record_summary, :id, :summary_type, :company_id, :customer_id, :item_id, :start_date, :end_date, :created_at, :updated_at
json.url transaction_record_summary_url(transaction_record_summary, format: :json)
