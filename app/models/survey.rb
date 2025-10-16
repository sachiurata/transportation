class Survey < ApplicationRecord
  has_many :requested_routes, dependent: :destroy
end
