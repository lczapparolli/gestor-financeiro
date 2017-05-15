class SecuredController < ApplicationController

  before_action :logged_in?

  private

  def logged_in?
    unless session[:hash].present?
      redirect_to "/login"
    else
      #TODO: Validates session_hash
      @user = User.find_by(session_hash: session[:hash])
      session_hash = BCrypt::Password.new(@user.session_hash)
      unless (session_hash == "#{@user.session_salt} - #{request.remote_ip} - #{@user.id} - #{@user.last_login}")
        @user.update(session_salt: nil, session_hash: nil)
        reset_session
      end
    end
  end

end
