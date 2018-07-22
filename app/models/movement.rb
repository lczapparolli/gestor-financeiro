class Movement < ActiveRecord::Base
  validates :description, :date, :amount, :account, :budget, :period, presence: true

  belongs_to :account
  belongs_to :budget
  belongs_to :period
  belongs_to :user

  #Scope to list movements ordering by Period start date and movement date
  scope :ordered_list, -> { 
    includes(:account, :budget, :period).
    order("periods.start DESC").
    order("movements.date DESC")
  }

  scope :limited, ->(rows, offset) {
    limit(rows).
    offset(offset)
  }
end
