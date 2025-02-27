# == Schema Information
#
# Table name: dealzs
#
#  id                    :integer          not null, primary key
#  price                 :decimal(, )
#  quantity              :integer
#  total_excl_vat        :decimal(, )
#  total_incl_vat        :decimal(, )
#  created_at            :datetime         not null
#  updated_at            :datetime         not null
#  item_id               :integer          not null
#  transaction_record_id :integer          not null
#  vat_rate_id           :integer          not null
#
# Indexes
#
#  index_dealzs_on_item_id                (item_id)
#  index_dealzs_on_transaction_record_id  (transaction_record_id)
#  index_dealzs_on_vat_rate_id            (vat_rate_id)
#
# Foreign Keys
#
#  item_id                (item_id => items.id)
#  transaction_record_id  (transaction_record_id => transaction_records.id)
#  vat_rate_id            (vat_rate_id => vat_rates.id)
#
class Dealz < ApplicationRecord
  belongs_to :item
  belongs_to :transaction_record
  belongs_to :vat_rate
end
