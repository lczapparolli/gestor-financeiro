class Budget < ActiveRecord::Base
  validates :name, presence: true

  has_many :movements
  has_many :budget_period
  belongs_to :user
  
  scope :limited, ->(rows, offset) {
    limit(rows).
    offset(offset)
  }
end
