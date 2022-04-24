class Menu < ApplicationRecord
  has_many :event_menus
  has_many :events, through: :event_menus
end
