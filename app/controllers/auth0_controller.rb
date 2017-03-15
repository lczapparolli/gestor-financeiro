class Auth0Controller < ApplicationController
  def callback
     # example request.env['omniauth.auth'] in https://github.com/auth0/omniauth-auth0#auth-hash
    # id_token = session[:userinfo]['credentials']['id_token']
    # store the user profile in session and redirect to root
    begin
      session[:code] = request.params['code']
      session[:userinfo] = request.env['omniauth.auth']

      user = User.find_by(auth_token: session[:userinfo]["uid"])
      unless user
        user = User.new
        user.auth_token = session[:userinfo]["uid"]
        user.save
      end

      redirect_to :root
    rescue => ex
      logger.error ex.message
    end
  end

  def failure
    @error_msg = request.params['message']
  end
end
