class PeriodsController < SecuredController
  before_action :set_period, only: [:show, :edit, :update, :destroy]

  # GET /periods
  # GET /periods.json
  def index
    @page = params[:page] ? params[:page].to_i : 1
    @rows = params[:rows] ? params[:rows].to_i : 10
    @totalPages = (Period.where(user: @user).count / @rows.to_f).ceil
    @periods = Period.where(user: @user).limit(@rows).offset((@page - 1) * @rows)
  end

  # GET /periods/1
  # GET /periods/1.json
  def show
    @page = params[:page] ? params[:page].to_i : 1
    @rows = params[:rows] ? params[:rows].to_i : 10
    @totalPages = (@period.movements.count / @rows.to_f).ceil
    @movements = @period.movements.order(date: :desc, id: :desc).limit(@rows).offset((@page - 1) * @rows)
  end

  # GET /periods/new
  def new
    @period = Period.new
  end

  # GET /periods/1/edit
  def edit
  end

  # POST /periods
  # POST /periods.json
  def create
    @period = Period.new(period_params)
    @period.user = @user

    respond_to do |format|
      if @period.save
        format.html { redirect_to @period, notice: 'Period was successfully created.' }
        format.json { render :show, status: :created, location: @period }
      else
        format.html { render :new }
        format.json { render json: @period.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /periods/1
  # PATCH/PUT /periods/1.json
  def update
    respond_to do |format|
      if @period.update(period_params)
        format.html { redirect_to @period, notice: 'Period was successfully updated.' }
        format.json { render :show, status: :ok, location: @period }
      else
        format.html { render :edit }
        format.json { render json: @period.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /periods/1
  # DELETE /periods/1.json
  def destroy
    @period.destroy
    respond_to do |format|
      format.html { redirect_to periods_url, notice: 'Period was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_period
      @period = Period.find(params[:id])
      if @period.user != @user
        redirect_to periods_url, notice: 'You do not have access to this period'
      end
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def period_params
      params.require(:period).permit(:name, :start, :end)
    end
end
