# == Schema Information
#
# Table name: deals
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
#  index_deals_on_item_id                (item_id)
#  index_deals_on_transaction_record_id  (transaction_record_id)
#  index_deals_on_vat_rate_id            (vat_rate_id)
#
# Foreign Keys
#
#  item_id                (item_id => items.id)
#  transaction_record_id  (transaction_record_id => transaction_records.id)
#  vat_rate_id            (vat_rate_id => vat_rates.id)
#
class Deal < ApplicationRecord
  belongs_to :item
  belongs_to :transaction_record
  belongs_to :vat_rate

  validates :quantity, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 1 }

  before_save :calculate_deal_totals

  after_save :update_transaction_record_totals
  after_destroy :update_transaction_record_totals

  def calculate_deal_totals
    self.total_excl_vat = quantity * price
    self.total_incl_vat = total_excl_vat * (1 + vat_rate.rate / 100.0)
  end

  private

  def update_transaction_record_totals
    transaction_record.reload.calculate_totals
  end
end
