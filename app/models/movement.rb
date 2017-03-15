class Movement < ActiveRecord::Base
  validates :description, :date, :amount, :account, :budget, :period, presence: true

  belongs_to :account
  belongs_to :budget
  belongs_to :period
  belongs_to :user
end
