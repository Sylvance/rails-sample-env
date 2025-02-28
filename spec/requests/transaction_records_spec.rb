require 'rails_helper'

RSpec.describe TransactionRecordsController, type: :controller do
  let(:company) { Company.create!(name: "Test Company") }
  let(:region) { company.regions.create(name: 'Faker::Address.city') }
  let(:customer) { company.customers.create!(name: 'Faker::Restaurant.name', region_id: region.id) }
  let(:user) { company.users.create(name: 'Faker::Name.name') }

  let(:valid_attributes) {
    { transaction_date: Date.today, notes: "Notes", total_amount_excl_vat: 100, total_amount_incl_vat: 120, company_id: company.id, customer_id: customer.id, user_id: user.id }
  }

  let(:invalid_attributes) {
    { transaction_date: nil, notes: nil, total_amount_excl_vat: nil, total_amount_incl_vat: nil, company_id: nil, customer_id: nil, user_id: nil }
  }

  describe "GET #index" do
    it "returns a success response" do
      TransactionRecord.create! valid_attributes
      get :index
      expect(response).to be_successful
    end
  end

  describe "GET #show" do
    it "returns a success response" do
      transaction_record = TransactionRecord.create! valid_attributes
      get :show, params: { id: transaction_record.to_param }
      expect(response).to be_successful
    end
  end

  describe "POST #create" do
    context "with valid params" do
      it "creates a new TransactionRecord" do
        expect {
          post :create, params: { transaction_record: valid_attributes }
        }.to change(TransactionRecord, :count).by(1)
      end

      it "redirects to the created transaction_record" do
        post :create, params: { transaction_record: valid_attributes }
        expect(response).to redirect_to(TransactionRecord.last)
      end
    end

    context "with invalid params" do
      it "does not create a new TransactionRecord" do
        expect {
          post :create, params: { transaction_record: invalid_attributes }
        }.not_to change(TransactionRecord, :count)
      end

      it "renders the 'new' template" do
        post :create, params: { transaction_record: invalid_attributes }
        expect(response).to render_template("new")
      end
    end
  end

  describe "PUT #update" do
    let(:new_attributes) {
      { notes: "New Notes" }
    }

    context "with valid params" do
      it "updates the requested transaction_record" do
        transaction_record = TransactionRecord.create! valid_attributes
        put :update, params: { id: transaction_record.to_param, transaction_record: new_attributes }
        transaction_record.reload
        expect(transaction_record.notes).to eq("New Notes")
      end

      it "redirects to the transaction_record" do
        transaction_record = TransactionRecord.create! valid_attributes
        put :update, params: { id: transaction_record.to_param, transaction_record: new_attributes }
        expect(response).to redirect_to(transaction_record)
      end
    end

    context "with invalid params" do
      it "renders the 'edit' template" do
        transaction_record = TransactionRecord.create! valid_attributes
        put :update, params: { id: transaction_record.to_param, transaction_record: invalid_attributes }
        expect(response).to render_template("edit")
      end
    end
  end
end
