FactoryBot.define do
  factory :transaction_record do
    transaction_date { Date.today }
    notes { "Sample Notes" }
    total_amount_excl_vat { 100 }
    total_amount_incl_vat { 120 }
    association :company
    association :customer
    association :user
  end
end
