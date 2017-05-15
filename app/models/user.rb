class User < ActiveRecord::Base
  has_secure_password
  validates :email, presence: true, uniqueness: true
  validates :session_hash, uniqueness: true, :allow_blank => true

  has_many :accounts
  has_many :budgets
  has_many :forecasts
  has_many :movements
  has_many :periods
end
