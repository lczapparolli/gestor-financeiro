class User < ActiveRecord::Base
  validates :auth_token, presence: true

  has_many :accounts
  has_many :budgets
  has_many :forecasts
  has_many :movements
  has_many :periods
end
