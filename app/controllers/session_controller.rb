class SessionController < SecuredController
  skip_before_action :logged_in?, only: [:new, :create, :css_test]
  layout "not_logged", only: [:new]
  
  #GET /login
  def new
    @user = User.new
  end

  #POST /login
  def create
    @user = User.find_by(email: params[:email])

    if @user && @user.authenticate(params[:password])
      @user.session_salt = srand(100000)
      @user.last_login = Time.now()
      @user.session_hash = BCrypt::Password.create("#{@user.session_salt} - #{request.remote_ip} - #{@user.id} - #{@user.last_login}").to_s
      @user.save()
      session[:hash] = @user.session_hash
      redirect_to root_url
    else
      #this part of script is only to prevent timming atacks
      unless @user
        @user = User.new(password: "myfakepassword")
      end
      @user.authenticate("myanotherfakepassword")
      @user.password = ""
      @user.email = params[:email]
      respond_to do |format|
        format.html { render :new, layout: "not_logged" }
      end
    end
  end

  #GET /logout
  def destroy
    @user.update(session_hash: nil, session_salt: nil)
    reset_session
    redirect_to root_url
  end

  def css_test
    render layout: nil
  end
end
