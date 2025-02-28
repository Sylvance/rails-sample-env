FactoryBot.define do
  factory :vat_rate do
    rate { 20 }
    association :item
    active_from { Date.today }
    active_to { Date.today }
  end
end
