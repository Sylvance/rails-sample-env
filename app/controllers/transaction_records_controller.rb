class TransactionRecordsController < ApplicationController
  include PaginationHelper
  include FilteringHelper

  before_action :set_transaction_record, only: %i[ show edit update destroy ]

  # GET /transaction_records or /transaction_records.json
  def index
    @transaction_records = TransactionRecord.all
    @transaction_records = filter_transaction_records(@transaction_records)
    @pagination = paginate(@transaction_records)
    @transaction_records = @pagination[:items]

    respond_to do |format|
      format.html
      format.csv { send_data generate_csv(@transaction_records), filename: "transaction_records-#{Date.today}.csv" }
    end
  end

  # GET /transaction_records/1 or /transaction_records/1.json
  def show
  end

  # GET /transaction_records/new
  def new
    @transaction_record = TransactionRecord.new
  end

  # GET /transaction_records/1/edit
  def edit
  end

  # POST /transaction_records or /transaction_records.json
  def create
    @transaction_record = TransactionRecord.new(transaction_record_params)

    respond_to do |format|
      if @transaction_record.save
        format.html { redirect_to @transaction_record, notice: "Transaction record was successfully created." }
        format.json { render :show, status: :created, location: @transaction_record }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @transaction_record.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /transaction_records/1 or /transaction_records/1.json
  def update
    respond_to do |format|
      if @transaction_record.update(transaction_record_params)
        format.html { redirect_to @transaction_record, notice: "Transaction record was successfully updated." }
        format.json { render :show, status: :ok, location: @transaction_record }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @transaction_record.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /transaction_records/1 or /transaction_records/1.json
  def destroy
    @transaction_record.destroy

    respond_to do |format|
      format.html { redirect_to transaction_records_path, status: :see_other, notice: "Transaction record was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_transaction_record
      @transaction_record = TransactionRecord.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def transaction_record_params
      params.require(:transaction_record).permit(:transaction_date, :notes, :total_amount_excl_vat, :total_amount_incl_vat, :company_id, :customer_id, :user_id)
    end

    def generate_csv(transaction_records)
      CSV.generate(headers: true) do |csv|
        csv << ["Transaction Date", "Customer", "Total Amount Excl VAT", "Total Amount Incl VAT"]

        transaction_records.each do |record|
          csv << [record.transaction_date, record.customer.name, record.total_amount_excl_vat, record.total_amount_incl_vat]
        end
      end
    end
end
