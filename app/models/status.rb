class Status < ApplicationRecord
  has_many :users, through: :user_statuses
end
