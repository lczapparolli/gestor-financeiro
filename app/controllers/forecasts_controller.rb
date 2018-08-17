class ForecastsController < SecuredController
  before_action :set_forecast, only: [:show, :edit, :update, :destroy]

  # GET /forecasts
  # GET /forecasts.json
  def index
    @page = params[:page] ? params[:page].to_i : 1
    @rows = params[:rows] ? params[:rows].to_i : 10
    @totalRows = Forecast.where(user: @user).count
    @forecasts = Forecast.
                  includes(:period, :budget).
                  where(user: @user).
                  order("periods.start DESC, periods.id, budgets.name").
                  limit(@rows).
                  offset((@page - 1) * @rows)
  end

  # GET /forecasts/1
  # GET /forecasts/1.json
  def show
    @page = params[:page] ? params[:page].to_i : 1
    @rows = params[:rows] ? params[:rows].to_i : 10
    @totalRows = Movement.where(period_id: @forecast.period_id, budget_id: @forecast.budget_id).count
    @movements = Movement.where(period_id: @forecast.period_id, budget_id: @forecast.budget_id).ordered_list.limited(@rows, (@page - 1) * @rows)
  end

  # GET /forecasts/new
  def new
    @forecast = Forecast.new
  	@budgets = Budget.where(user: @user).order(:name)
  	@periods = Period.where(user: @user).order(start: :desc, id: :desc)
  end

  # GET /forecasts/1/edit
  def edit
    @budgets = Budget.where(user: @user).order(:name)
    @periods = Period.where(user: @user).order(start: :desc, id: :desc)
  end

  # POST /forecasts
  # POST /forecasts.json
  def create
    @forecast = Forecast.new(forecast_params)
    @forecast.user = @user

    respond_to do |format|
      if @forecast.save
        format.html { redirect_to @forecast, notice: 'Forecast was successfully created.' }
        format.json { render :show, status: :created, location: @forecast }
      else
        format.html { render :new }
        format.json { render json: @forecast.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /forecasts/1
  # PATCH/PUT /forecasts/1.json
  def update
    respond_to do |format|
      if @forecast.update(forecast_params)
        format.html { redirect_to @forecast, success: 'Forecast was successfully updated.' }
        format.json { render :show, status: :ok, location: @forecast }
      else
        format.html { render :edit }
        format.json { render json: @forecast.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /forecasts/1
  # DELETE /forecasts/1.json
  def destroy
    @forecast.destroy
    respond_to do |format|
      format.html { redirect_to forecasts_url, success: 'Forecast was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def resource_description
    @forecast.period.name + ' - ' + @forecast.budget.name
  end
  
  private
    # Use callbacks to share common setup or constraints between actions.
    def set_forecast
      @forecast = Forecast.where(id: params[:id]).first()
      unless @forecast && @forecast.user == @user
        redirect_to forecasts_url, alert: 'Forecast not found.'
      end
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def forecast_params
      params.require(:forecast).permit(:period_id, :budget_id, :amount)
    end
end
