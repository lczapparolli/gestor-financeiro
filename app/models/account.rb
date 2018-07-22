class Account < ActiveRecord::Base
  validates :name, presence: true

  has_many :movements
  belongs_to :user

  scope :with_balance, -> {
    select("accounts.id, accounts.name, sum(movements.amount) as balance"). 
    joins(:movements).
    group("accounts.id, accounts.name").
    order("accounts.name")
  }

  scope :limited, ->(rows, offset) {
    limit(rows).
    offset(offset)
  }
end
