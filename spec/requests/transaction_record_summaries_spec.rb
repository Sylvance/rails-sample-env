require 'rails_helper'

RSpec.describe TransactionRecordSummariesController, type: :controller do
  let(:company) { Company.create!(name: "Test Company") }
  let(:region) { company.regions.create(name: 'Faker::Address.city') }
  let(:customer) { company.customers.create!(name: 'Faker::Restaurant.name', region_id: region.id) }
  let(:user) { company.users.create(name: 'Faker::Name.name') }
  let(:item_attributes) {
    { name: "Item Name", description: "Item Description", company_id: company.id }
  }
  let(:item) { Item.create! item_attributes }
  let(:valid_attributes) {
    { summary_type: "Type", company_id: company.id, customer_id: customer.id, item_id: item.id, start_date: Date.today, end_date: Date.today }
  }

  let(:invalid_attributes) {
    { summary_type: nil, company_id: nil, customer_id: nil, item_id: nil, start_date: nil, end_date: nil }
  }

  describe "GET #index" do
    it "returns a success response" do
      TransactionRecordSummary.create! valid_attributes
      get :index
      expect(response).to be_successful
    end
  end

  describe "GET #show" do
    it "returns a success response" do
      transaction_record_summary = TransactionRecordSummary.create! valid_attributes
      get :show, params: { id: transaction_record_summary.to_param }
      expect(response).to be_successful
    end
  end

  describe "POST #create" do
    context "with valid params" do
      it "creates a new TransactionRecordSummary" do
        expect {
          post :create, params: { transaction_record_summary: valid_attributes }
        }.to change(TransactionRecordSummary, :count).by(1)
      end

      it "redirects to the created transaction_record_summary" do
        post :create, params: { transaction_record_summary: valid_attributes }
        expect(response).to redirect_to(TransactionRecordSummary.last)
      end
    end

    context "with invalid params" do
      it "does not create a new TransactionRecordSummary" do
        expect {
          post :create, params: { transaction_record_summary: invalid_attributes }
        }.not_to change(TransactionRecordSummary, :count)
      end

      it "renders the 'new' template" do
        post :create, params: { transaction_record_summary: invalid_attributes }
        expect(response).to render_template("new")
      end
    end
  end

  describe "PUT #update" do
    let(:new_attributes) {
      { summary_type: "New Type" }
    }

    context "with valid params" do
      it "updates the requested transaction_record_summary" do
        transaction_record_summary = TransactionRecordSummary.create! valid_attributes
        put :update, params: { id: transaction_record_summary.to_param, transaction_record_summary: new_attributes }
        transaction_record_summary.reload
        expect(transaction_record_summary.summary_type).to eq("New Type")
      end

      it "redirects to the transaction_record_summary" do
        transaction_record_summary = TransactionRecordSummary.create! valid_attributes
        put :update, params: { id: transaction_record_summary.to_param, transaction_record_summary: new_attributes }
        expect(response).to redirect_to(transaction_record_summary)
      end
    end

    context "with invalid params" do
      it "renders the 'edit' template" do
        transaction_record_summary = TransactionRecordSummary.create! valid_attributes
        put :update, params: { id: transaction_record_summary.to_param, transaction_record_summary: invalid_attributes }
        expect(response).to render_template("edit")
      end
    end
  end

  describe "DELETE #destroy" do
    it "destroys the requested transaction_record_summary" do
      transaction_record_summary = TransactionRecordSummary.create! valid_attributes
      expect {
        delete :destroy, params: { id: transaction_record_summary.to_param }
      }.to change(TransactionRecordSummary, :count).by(-1)
    end

    it "redirects to the transaction_record_summaries list" do
      transaction_record_summary = TransactionRecordSummary.create! valid_attributes
      delete :destroy, params: { id: transaction_record_summary.to_param }
      expect(response).to redirect_to(transaction_record_summaries_url)
    end
  end
end
