class Event < ApplicationRecord
  belongs_to :user
  has_many :menus
  has_many :menus, through: :event_menus
  has_many :business_times
end
