class Survey < ApplicationRecord
  belongs_to :admin_user
  has_many :requested_routes, dependent: :destroy

  validates :survey_name, presence: true
end
