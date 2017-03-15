class UserController < SecuredController
  skip_before_action :logged_in_using_omniauth?, only: [:login]
  layout false, :only => [:login]

  def login
    if session[:userinfo].present?
      redirect_to :root	
    end
  end

  def logout
    reset_session
    redirect_to "https://#{Figaro.env.auth0_domain}/v2/logout?returnTo=#{request.base_url}"
  end

  def profile
  end
end
