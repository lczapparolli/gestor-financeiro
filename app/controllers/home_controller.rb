class HomeController < SecuredController

  def index
    @periods = Period.where(user: @user)
    @period = params[:period_id]? Period.find(params[:period_id]): Period.where(user: @user).last
    if @period && @period.user != @user
      @period = Period.where(user: @user).last
    end
    unless @period
      @period = Period.new
    end
    @forecasts = Forecast.where(period_id: @period.id, user: @user)
  end

end
