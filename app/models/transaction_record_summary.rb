# == Schema Information
#
# Table name: transaction_record_summaries
#
#  id           :integer          not null, primary key
#  end_date     :date
#  start_date   :date
#  summary_type :string
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  company_id   :integer          not null
#  customer_id  :integer          not null
#  item_id      :integer          not null
#
# Indexes
#
#  index_transaction_record_summaries_on_company_id   (company_id)
#  index_transaction_record_summaries_on_customer_id  (customer_id)
#  index_transaction_record_summaries_on_item_id      (item_id)
#
# Foreign Keys
#
#  company_id   (company_id => companies.id)
#  customer_id  (customer_id => customers.id)
#  item_id      (item_id => items.id)
#
class TransactionRecordSummary < ApplicationRecord
  belongs_to :company
  belongs_to :customer
  belongs_to :item

  # Virtual attributes for calculated totals
  attr_reader :amount_excl_vat, :amount_incl_vat
  
  # Calculate amounts before validation
  before_validation :calculate_amounts

  def calculate_amounts
    case summary_type
    when 'customer'
      calculate_customer_amounts
    when 'item'
      calculate_item_amounts
    end
  end

  def calculate_customer_amounts
    transactions = TransactionRecord.where(
      customer_id: customer_id,
      transaction_date: start_date..end_date
    )

    @amount_excl_vat = transactions.sum(:total_amount_excl_vat)
    @amount_incl_vat = transactions.sum(:total_amount_incl_vat)
  end

  def calculate_item_amounts
    transactions = Item.where(id: item_id).first.company.transaction_records.where(
      transaction_date: start_date..end_date
    )

    @amount_excl_vat = transactions.sum(:total_amount_excl_vat)
    @amount_incl_vat = transactions.sum(:total_amount_incl_vat)
  end

  def amount_excl_vat
    calculate_amounts if @amount_excl_vat.nil?
    @amount_excl_vat
  end

  def amount_incl_vat
    calculate_amounts if @amount_incl_vat.nil?
    @amount_incl_vat
  end
end
