class DealzsController < ApplicationController
  before_action :set_dealz, only: %i[ show edit update destroy ]

  # GET /dealzs or /dealzs.json
  def index
    @dealzs = Dealz.all
  end

  # GET /dealzs/1 or /dealzs/1.json
  def show
  end

  # GET /dealzs/new
  def new
    @dealz = Dealz.new
  end

  # GET /dealzs/1/edit
  def edit
  end

  # POST /dealzs or /dealzs.json
  def create
    @dealz = Dealz.new(dealz_params)

    respond_to do |format|
      if @dealz.save
        format.html { redirect_to @dealz, notice: "Dealz was successfully created." }
        format.json { render :show, status: :created, location: @dealz }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @dealz.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /dealzs/1 or /dealzs/1.json
  def update
    respond_to do |format|
      if @dealz.update(dealz_params)
        format.html { redirect_to @dealz, notice: "Dealz was successfully updated." }
        format.json { render :show, status: :ok, location: @dealz }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @dealz.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /dealzs/1 or /dealzs/1.json
  def destroy
    @dealz.destroy

    respond_to do |format|
      format.html { redirect_to dealzs_path, status: :see_other, notice: "Dealz was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_dealz
      @dealz = Dealz.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def dealz_params
      params.require(:dealz).permit(:item_id, :transaction_record_id, :quantity, :price, :vat_rate_id, :total_excl_vat, :total_incl_vat)
    end
end
