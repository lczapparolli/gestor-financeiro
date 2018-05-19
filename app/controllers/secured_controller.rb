class SecuredController < ApplicationController

  before_action :logged_in?

  private

  def logged_in?
    logged = false
    if session[:hash].present?
      @user = User.find_by(session_hash: session[:hash])
      if @user
        session_hash = BCrypt::Password.new(@user.session_hash)
        if (session_hash == "#{@user.session_salt} - #{request.remote_ip} - #{@user.id} - #{@user.last_login}")
          logged = true
        else
          @user.update(session_salt: nil, session_hash: nil)
          reset_session
        end
      end
    end
    unless logged
      redirect_to "/login"
    end
  end

end
