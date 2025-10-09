class Child < ApplicationRecord
  belongs_to :user
  has_many :requested_routes, as: :subject, dependent: :destroy
  has_many :answers, as: :subject, dependent: :destroy

  enum school_type: { elementary: 0, secondary: 1, high: 2 }
end
