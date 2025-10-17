class Survey < ApplicationRecord
  belongs_to :admin_user
  has_many :questions, dependent: :destroy
  has_many :requested_routes, dependent: :destroy
  has_many :answers, through: :questions

  validates :survey_name, presence: true
end
