class SecuredController < ApplicationController

  before_action :logged_in_using_omniauth?

  private

  def logged_in_using_omniauth?
    unless session[:userinfo].present?
      redirect_to "/user/login"
    else
      @user = User.find_by(auth_token: session[:userinfo]["uid"])
      @user_info = session[:userinfo]
    end
  end

end
