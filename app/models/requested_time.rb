class RequestedTime < ApplicationRecord
  belongs_to :requested_route

  validates :requested_day, presence: true
  validates :requested_time, presence: true
end
