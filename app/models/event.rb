class Event < ApplicationRecord

  validates :date, presence: true
  validates :start, presence: true
  validates :end, presence: true

  belongs_to :user
  has_many :event_menus, autosave: true
  has_many :menus, through: :event_menus
end
