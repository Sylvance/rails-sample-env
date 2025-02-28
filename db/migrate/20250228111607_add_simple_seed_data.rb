class AddSimpleSeedData < ActiveRecord::Migration[6.1]
  def up
    200.times do |i|
      # Create a company
      company = Company.create!(name: "Test Company #{i + 1}")

      # Create a region for the company
      region = company.regions.create!(name: "Test Region #{i + 1}")

      # Create a customer for the company and region
      customer = company.customers.create!(name: "Test Customer #{i + 1}", region_id: region.id)

      # Create a user for the company
      user = company.users.create!(name: "Test User #{i + 1}")

      # Create a transaction record
      transaction_record = TransactionRecord.create!(
        transaction_date: Date.today,
        notes: "Test Notes #{i + 1}",
        total_amount_excl_vat: 100,
        total_amount_incl_vat: 120,
        company_id: company.id,
        customer_id: customer.id,
        user_id: user.id
      )

      # Create an item for the company
      item = Item.create!(
        name: "Test Item #{i + 1}",
        description: "Test Description #{i + 1}",
        company_id: company.id
      )

      # Create a VAT rate for the item
      vat_rate = VatRate.create!(
        rate: 20,
        item_id: item.id,
        active_from: Date.today,
        active_to: Date.today
      )

      # Create a deal
      Deal.create!(
        item_id: item.id,
        transaction_record_id: transaction_record.id,
        quantity: 1,
        price: 100,
        vat_rate_id: vat_rate.id,
        total_excl_vat: 100,
        total_incl_vat: 120
      )
    end
  end

  def down
    # Remove all seeded data
    Deal.destroy_all
    VatRate.destroy_all
    Item.destroy_all
    TransactionRecord.destroy_all
    User.destroy_all
    Customer.destroy_all
    Region.destroy_all
    Company.destroy_all
  end
end
