class Event < ApplicationRecord
  belongs_to :user
  has_many :event_menus, autosave: true
  has_many :menus, through: :event_menus
end
