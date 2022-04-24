class Event < ApplicationRecord
  belongs_to :user
  has_many :event_menus, autosave: true
  has_many :menus, through: :event_menus
  has_many :business_times, autosave: true
end
