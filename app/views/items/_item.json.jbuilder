json.extract! item, :id, :name, :description, :company_id, :created_at, :updated_at
json.url item_url(item, format: :json)
