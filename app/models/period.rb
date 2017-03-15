class Period < ActiveRecord::Base
  validates :name, :start, :end, presence: true

  has_many :movements
  has_many :budget_periods
  belongs_to :user
end
