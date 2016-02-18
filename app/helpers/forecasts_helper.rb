module ForecastsHelper

  def forecastBalancePercent(forecast)
    balance = Movement.where(period_id: forecast.period_id, budget_id: forecast.budget_id).sum(:amount)
    if forecast.amount == 0
      percent = 100
    else
      percent = (balance / forecast.amount) * 100
    end
    if (percent < 0)
      percent = 0
    elsif percent > 100
      percent = 100
    end
    return percent
  end

  def forecastBalanceMeter(forecast)
    percent = forecastBalancePercent(forecast)
    if (percent < 80)
      spanClass = "success"
    elsif (percent < 95)
      spanClass = "secondary"
    else
      spanClass = "alert"
    end
    return "<div class=\"progress #{spanClass}\"><span class=\"meter\" style=\"width: #{percent}%\" /></div>".html_safe
  end

end
