class ReportsController < ApplicationController
  before_action :return_date_groups, only: [:account_evolution]

  def account_evolution
    @report = Array.new
    @group = params[:group] ? params[:group].to_sym : :day
    @end = params[:end] ? params[:end].to_time : Time.new().change(:hour => 0)
    @start = params[:start] ? params[:start].to_time : @end - 1.month
    @accounts = params[:accounts] ? Account.find(params[:accounts]) : Account.all
    @accounts.each do |account|
      curr_date = @start
      reportItem = {name: account.name, data: Hash.new}
      while curr_date <= @end
        curr_date = curr_date.change(:hour => 0) # zero out hrs, mins, secs, usecs
        reportItem[:data][curr_date] = account.movements.where("date <= ?", curr_date).sum(:amount).round(2)
        curr_date = case @group
                    when :day
                      curr_date + 1.day
                    when :month
                      curr_date + 1.month
                    when :year
                      curr_date + 1.year
                    end
      end
      @report.push(reportItem)
    end
    #@accounts = Account.all
    #@report = @accounts.map{|account|
    #  {name: account.name, data: account.movements.where("date > ?", Time.new - 1.month).group(:date).sum(:amount)}
    #}
  end

  def account_evolution_execute
  end

  def budget_evolution
  end

  def budget_evolution
  end

  def total_balance
  end

  private
    def return_date_groups
      @date_groups = {"Day" => :day, "Month" => :month, "Year" => :year}
    end
end
