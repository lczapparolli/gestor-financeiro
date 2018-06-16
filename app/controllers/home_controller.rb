class HomeController < SecuredController

  def index
    @periods = Period.where(user: @user).order(start: :desc, id: :desc)
    if (params[:period_id])
      @period = Period.find(params[:period_id])
    end
    unless @period && @period.user == @user
      @period = Period.where(user: @user).order(start: :desc, id: :desc).first
    end
    unless @period
      @period = Period.new
    end
    @forecasts = Forecast.where(period_id: @period.id, user: @user).order(:amount)
  end

end
