class BusinessTime < ApplicationRecord

  validates :date, presence: true
  validates :time, presence: true
  validates :available, presence: true

end
