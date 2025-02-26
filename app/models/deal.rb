# == Schema Information
#
# Table name: deals
#
#  id             :integer          not null, primary key
#  price          :decimal(, )
#  quantity       :integer
#  total_excl_vat :decimal(, )
#  total_incl_vat :decimal(, )
#  vat_rate       :decimal(, )
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  item_id        :integer          not null
#  transaction_id :integer          not null
#
# Indexes
#
#  index_deals_on_item_id         (item_id)
#  index_deals_on_transaction_id  (transaction_id)
#
# Foreign Keys
#
#  item_id         (item_id => items.id)
#  transaction_id  (transaction_id => transactions.id)
#
class Deal < ApplicationRecord
  belongs_to :item
  belongs_to :transaction_record, class_name: 'Transaction'
end
