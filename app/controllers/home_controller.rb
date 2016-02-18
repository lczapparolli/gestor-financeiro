class HomeController < ApplicationController
  def index
    @periods = Period.all
    @period_id = params[:period_id] || Period.last.id
    @forecasts = Forecast.where(period_id: @period_id)
  end
end
