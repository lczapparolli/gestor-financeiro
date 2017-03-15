class MovementsController < SecuredController
  before_action :set_movement, only: [:show, :edit, :update, :destroy]

  # GET /movements
  # GET /movements.json
  def index
    @page = params[:page] ? params[:page].to_i : 1
    @rows = params[:rows] ? params[:rows].to_i : 10
    @totalPages = (Movement.where(user: @user).count / @rows.to_f).ceil
    @movements = Movement.where(user: @user).limit(@rows).offset((@page - 1) * @rows)
  end

  # GET /movements/1
  # GET /movements/1.json
  def show
  end

  # GET /movements/new
  def new
    @movement = Movement.new
    if params[:period_id]
      @movement.period_id = params[:period_id]
    end
    if params[:budget_id]
      @movement.budget_id = params[:budget_id]
    end
    if params[:account_id]
      @movement.account_id = params[:account_id]
    end
  end

  # GET /movements/1/edit
  def edit
  end

  # POST /movements
  # POST /movements.json
  def create
    @movement = Movement.new(movement_params)
    @movement.user = @user

    respond_to do |format|
      if @movement.save
        redirect_info = redirect_params
        if redirect_info['resource'] && redirect_info['id'] && redirect_info['resource'] != '' && redirect_info['resource'] != ''
          format.html { redirect_to url_for(controller: redirect_info['resource'], action: 'show', id: redirect_info['id']), notice: 'Movement was successfully created.' }
        else
          format.html { redirect_to @movement, notice: 'Movement was successfully created.' }
        end
        format.json { render :show, status: :created, location: @movement }
      else
        format.html { render :new }
        format.json { render json: @movement.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /movements/1
  # PATCH/PUT /movements/1.json
  def update
    respond_to do |format|
      if @movement.update(movement_params)
        redirect_info = redirect_params
        puts redirect_info
        if redirect_info['resource'] && redirect_info['id'] && redirect_info['resource'] != '' && redirect_info['resource'] != ''
          format.html { redirect_to url_for(controller: redirect_info['resource'], action: 'show', id: redirect_info['id']), notice: 'Movement was successfully updated.' }
        else
          format.html { redirect_to @movement, notice: 'Movement was successfully updated.' }
        end
        format.json { render :show, status: :ok, location: @movement }
      else
        format.html { render :edit }
        format.json { render json: @movement.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /movements/1
  # DELETE /movements/1.json
  def destroy
    @movement.destroy
    respond_to do |format|
      format.html { redirect_to movements_url, notice: 'Movement was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_movement
      @movement = Movement.find(params[:id])
      if @movement.user != @user
        redirect_to movements_url, notice: 'You do not have access to this movement'
      end
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def movement_params
      params.require(:movement).permit(:description, :date, :amount, :account_id, :budget_id, :period_id)
    end

    def redirect_params
      params.require(:redirect).permit(:resource, :id)
    end
end
