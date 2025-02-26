json.extract! deal, :id, :item_id, :transaction_id, :quantity, :price, :vat_rate, :total_excl_vat, :total_incl_vat, :created_at, :updated_at
json.url deal_url(deal, format: :json)
