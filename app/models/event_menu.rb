class EventMenu < ApplicationRecord
  belongs_to :event
  belongs_to :menu
  belongs_to :user
end