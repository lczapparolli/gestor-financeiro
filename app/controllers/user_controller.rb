class UserController < SecuredController
  skip_before_action :logged_in?, only: [:new, :create]
  #set_user is not necessary, logged_in already sets @user
  layout "not_logged", only: [:new, :create]

  # GET /register
  def new
    @new_user = User.new
  end

  # GET /me
  def edit
  end

  # POST /register
  def create
    @new_user = User.new(user_params)

    respond_to do |format|
      if @new_user.save
        format.html { redirect_to root_url, notice: 'You are successfully registered. Please Log in =)' }
        format.json { render :show, status: :created, location: @new_user }
      else
        format.html { render :new }
        format.json { render json: @new_user.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /me
  # PATCH/PUT /me.json
  def update
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to root_url, notice: 'You are successfully registered.' }
        format.json { render :show, status: :created, location: @new_user }
      else
        format.html { render :new }
        format.json { render json: @new_user.errors, status: :unprocessable_entity }
      end
    end
  end

  private
    # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
      params.require(:user).permit(:first_name, :last_name, :email, :password, :password_confirmation)
    end

end
