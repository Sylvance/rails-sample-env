# == Schema Information
#
# Table name: vat_rates
#
#  id          :integer          not null, primary key
#  active_from :date
#  active_to   :date
#  rate        :decimal(, )
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  item_id     :integer          not null
#
# Indexes
#
#  index_vat_rates_on_item_id  (item_id)
#
# Foreign Keys
#
#  item_id  (item_id => items.id)
#
FactoryBot.define do
  factory :vat_rate do
    rate { 20 }
    association :item
    active_from { Date.today }
    active_to { Date.today }
  end
end
