# == Schema Information
#
# Table name: transaction_records
#
#  id                    :integer          not null, primary key
#  notes                 :text
#  total_amount_excl_vat :decimal(, )
#  total_amount_incl_vat :decimal(, )
#  transaction_date      :date
#  created_at            :datetime         not null
#  updated_at            :datetime         not null
#  company_id            :integer          not null
#  customer_id           :integer          not null
#  user_id               :integer          not null
#
# Indexes
#
#  index_transaction_records_on_company_id   (company_id)
#  index_transaction_records_on_customer_id  (customer_id)
#  index_transaction_records_on_user_id      (user_id)
#
# Foreign Keys
#
#  company_id   (company_id => companies.id)
#  customer_id  (customer_id => customers.id)
#  user_id      (user_id => users.id)
#
class TransactionRecord < ApplicationRecord
  belongs_to :company
  belongs_to :customer
  belongs_to :user
  has_many :deals, dependent: :destroy
end
