class Menu < ApplicationRecord
  has_many :events
  has_many :events, through: :event_menus
end
