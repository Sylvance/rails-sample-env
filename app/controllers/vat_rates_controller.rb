class VatRatesController < ApplicationController
  before_action :set_vat_rate, only: %i[ show edit update destroy ]

  # GET /vat_rates or /vat_rates.json
  def index
    @vat_rates = VatRate.all
  end

  # GET /vat_rates/1 or /vat_rates/1.json
  def show
  end

  # GET /vat_rates/new
  def new
    @vat_rate = VatRate.new
  end

  # GET /vat_rates/1/edit
  def edit
  end

  # POST /vat_rates or /vat_rates.json
  def create
    @vat_rate = VatRate.new(vat_rate_params)

    respond_to do |format|
      if @vat_rate.save
        format.html { redirect_to @vat_rate, notice: "Vat rate was successfully created." }
        format.json { render :show, status: :created, location: @vat_rate }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @vat_rate.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /vat_rates/1 or /vat_rates/1.json
  def update
    respond_to do |format|
      if @vat_rate.update(vat_rate_params)
        format.html { redirect_to @vat_rate, notice: "Vat rate was successfully updated." }
        format.json { render :show, status: :ok, location: @vat_rate }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @vat_rate.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /vat_rates/1 or /vat_rates/1.json
  def destroy
    @vat_rate.destroy

    respond_to do |format|
      format.html { redirect_to vat_rates_path, status: :see_other, notice: "Vat rate was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_vat_rate
      @vat_rate = VatRate.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def vat_rate_params
      params.require(:vat_rate).permit(:rate, :item_id, :active_from, :active_to)
    end
end
