class RequestedRoute < ApplicationRecord
  belongs_to :subject, polymorphic: true
  belongs_to :survey
  has_many :requested_times, dependent: :destroy
  accepts_nested_attributes_for :requested_times, allow_destroy: true

  validates :start_point_location, presence: true
  validates :end_point_location, presence: true
  validates :is_existing_service_available, inclusion: { in: [ true, false ] }
end
