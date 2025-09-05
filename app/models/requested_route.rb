class RequestedRoute < ApplicationRecord
  belongs_to :user

  validates :start_point_location, presence: true
  validates :end_point_location, presence: true
  validates :is_existing_service_available, inclusion: { in: [ true, false ] }
end
