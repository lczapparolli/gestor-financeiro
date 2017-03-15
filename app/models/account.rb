class Account < ActiveRecord::Base
  validates :name, presence: true

  has_many :movements
  belongs_to :user
end
