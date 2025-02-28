class TransactionRecordSummariesController < ApplicationController
  before_action :set_transaction_record_summary, only: %i[ show edit update destroy ]

  # GET /transaction_record_summaries or /transaction_record_summaries.json
  def index
    @transaction_record_summaries = TransactionRecordSummary.all
  end

  # GET /transaction_record_summaries/1 or /transaction_record_summaries/1.json
  def show
  end

  # GET /transaction_record_summaries/new
  def new
    @transaction_record_summary = TransactionRecordSummary.new
  end

  # GET /transaction_record_summaries/1/edit
  def edit
  end

  # POST /transaction_record_summaries or /transaction_record_summaries.json
  def create
    @transaction_record_summary = TransactionRecordSummary.new(transaction_record_summary_params)

    respond_to do |format|
      if @transaction_record_summary.save
        format.html { redirect_to @transaction_record_summary, notice: "Transaction record summary was successfully created." }
        format.json { render :show, status: :created, location: @transaction_record_summary }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @transaction_record_summary.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /transaction_record_summaries/1 or /transaction_record_summaries/1.json
  def update
    respond_to do |format|
      if @transaction_record_summary.update(transaction_record_summary_params)
        format.html { redirect_to @transaction_record_summary, notice: "Transaction record summary was successfully updated." }
        format.json { render :show, status: :ok, location: @transaction_record_summary }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @transaction_record_summary.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /transaction_record_summaries/1 or /transaction_record_summaries/1.json
  def destroy
    @transaction_record_summary.destroy

    respond_to do |format|
      format.html { redirect_to transaction_record_summaries_path, status: :see_other, notice: "Transaction record summary was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_transaction_record_summary
      @transaction_record_summary = TransactionRecordSummary.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def transaction_record_summary_params
      params.require(:transaction_record_summary).permit(:summary_type, :company_id, :customer_id, :item_id, :start_date, :end_date)
    end
end
