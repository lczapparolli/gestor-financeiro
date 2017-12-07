class AccountsController < SecuredController
  before_action :set_account, only: [:show, :edit, :update, :destroy]

  # GET /accounts
  # GET /accounts.json
  def index
    @page = params[:page] ? params[:page].to_i : 1
    @rows = params[:rows] ? params[:rows].to_i : 10
    @totalPages = (Account.where(user: @user).count / @rows.to_f).ceil
    @accounts = Account.where(user: @user).limit(@rows).offset((@page - 1) * @rows)
  end

  # GET /accounts/1
  # GET /accounts/1.json
  def show
    @page = params[:page] ? params[:page].to_i : 1
    @rows = params[:rows] ? params[:rows].to_i : 10
    @totalPages = (@account.movements.count / @rows.to_f).ceil
    @movements = @account.movements.order(date: :desc, id: :desc).limit(@rows).offset((@page - 1) * @rows)
  end

  # GET /accounts/new
  def new
    @account = Account.new
  end

  # GET /accounts/1/edit
  def edit
  end

  # POST /accounts
  # POST /accounts.json
  def create
    @account = Account.new(account_params)
    @account.user = @user

    respond_to do |format|
      if @account.save
        format.html { redirect_to @account, notice: 'Account was successfully created.' }
        format.json { render :show, status: :created, location: @account }
      else
        format.html { render :new }
        format.json { render json: @account.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /accounts/1
  # PATCH/PUT /accounts/1.json
  def update
    respond_to do |format|
      if @account.update(account_params)
        format.html { redirect_to @account, notice: 'Account was successfully updated.' }
        format.json { render :show, status: :ok, location: @account }
      else
        format.html { render :edit }
        format.json { render json: @account.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /accounts/1
  # DELETE /accounts/1.json
  def destroy
    @account.destroy
    respond_to do |format|
      format.html { redirect_to accounts_url, notice: 'Account was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_account
      @account = Account.find(params[:id])
      if @account.user != @user
        redirect_to accounts_url, notice: 'You do not have access to this account'
      end
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def account_params
      params.require(:account).permit(:name)
    end
end
