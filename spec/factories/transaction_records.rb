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
