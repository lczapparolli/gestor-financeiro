module ForecastsHelper

  def balancePercent(amount, balance)
    percent = 0.0
    if amount == 0
      if balance == 0
        percent = 0
      else
        percent = 100
      end
    else
      percent = (balance / amount) * 100
    end
    return percent
  end

  def forecastBalancePercent(forecast)
    balance = Movement.where(period_id: forecast.period_id, budget_id: forecast.budget_id).sum(:amount)
    return balancePercent(forecast.amount, balance)
  end

  def balanceMeter(amount, percent)
    percentExtra=0
    secondaryClass = "alert"
    if (amount == 0)
      spanClass = "alert"
    elsif (amount > 0)
      spanClass = "success"
    elsif (percent < 80)
      spanClass = "success"
    elsif (percent <= 100)
      spanClass = "warning"
    end
    if (percent > 100)
      if (amount > 0)
        spanClass = ""
        secondaryClass = "success"
      else
        spanClass = "warning"
      end
      percent = 10000 / percent
      percentExtra = 100 - percent
    end
    return "<div class=\"progress\">
              <span class=\"progress-item #{spanClass}\" style=\"width: #{percent}%\"></span>
              <span class=\"progress-item #{secondaryClass}\" style=\"width: #{percentExtra}%\"></span>
            </div>".html_safe
  end

  def forecastBalanceMeter(forecast)
    percent = forecastBalancePercent(forecast)
    return balanceMeter(forecast.amount, percent)
  end

end
