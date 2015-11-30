class ReportsController < ApplicationController

  def account_evolution
    @end = params[:end] || DateTime.now
    @start = params[:start] || @end << 1
    @curr_date = @start
    @report = Hash.new
    while @curr_date < @end
      @curr_date = @curr_date + 1
      @report[@curr_date] = Account.group(:name).joins("LEFT OUTER JOIN movements on movements.id = account.movement_id and movements.date <= ?", @curr_date)
    end

  end

  def account_evolution_execute
  end

  def budget_evolution
  end

  def budget_evolution
  end

  def total_balance
  end

end
