FactoryBot.define do
  factory :item do
    name { "Sample Item" }
    description { "Sample Description" }
    association :company
  end
end
