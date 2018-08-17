class BudgetsController < SecuredController
  before_action :set_budget, only: [:show, :edit, :update, :destroy]

  # GET /budgets
  # GET /budgets.json
  def index
    @page = params[:page] ? params[:page].to_i : 1
    @rows = params[:rows] ? params[:rows].to_i : 10
    @totalRows = Budget.where(user: @user).count
    @budgets = Budget.where(user: @user).order(:name).limit(@rows).offset((@page - 1) * @rows)
  end

  # GET /budgets/1
  # GET /budgets/1.json
  def show
    @page = params[:page] ? params[:page].to_i : 1
    @rows = params[:rows] ? params[:rows].to_i : 10
    @totalRows = @budget.movements.count
    @movements = @budget.movements.ordered_list.limited(@rows, (@page - 1) * @rows)
  end

  # GET /budgets/new
  def new
    @budget = Budget.new
  end

  # GET /budgets/1/edit
  def edit
  end

  # POST /budgets
  # POST /budgets.json
  def create
    @budget = Budget.new(budget_params)
    @budget.user = @user

    respond_to do |format|
      if @budget.save
        format.html { redirect_to @budget, success: 'Budget was successfully created.' }
        format.json { render :show, status: :created, location: @budget }
      else
        format.html { render :new }
        format.json { render json: @budget.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /budgets/1
  # PATCH/PUT /budgets/1.json
  def update
    respond_to do |format|
      if @budget.update(budget_params)
        format.html { redirect_to @budget, success: 'Budget was successfully updated.' }
        format.json { render :show, status: :ok, location: @budget }
      else
        format.html { render :edit }
        format.json { render json: @budget.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /budgets/1
  # DELETE /budgets/1.json
  def destroy
    @budget.destroy
    respond_to do |format|
      format.html { redirect_to budgets_url, notice: 'Budget was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def resource_description
    @budget.name
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_budget
      @budget = Budget.where(id: params[:id]).first()
      unless @budget && @budget.user == @user
        redirect_to budgets_url, alert: 'Budget not found.'
      end
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def budget_params
      params.require(:budget).permit(:name)
    end
end
