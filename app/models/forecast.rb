class Forecast < ActiveRecord::Base
  validates :period, :budget, :amount, presence: true

  belongs_to :period
  belongs_to :budget
  belongs_to :user
  
  scope :limited, ->(rows, offset) {
    limit(rows).
    offset(offset)
  }
end
