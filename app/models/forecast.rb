class Forecast < ActiveRecord::Base
  validates :period, :budget, :amount, presence: true

  belongs_to :period
  belongs_to :budget
end
