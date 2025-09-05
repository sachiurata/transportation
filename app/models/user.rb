class User < ApplicationRecord
  has_many :requested_routes, dependent: :destroy

  # パスワードを安全に保存するための機能
  has_secure_password

  # emailの入力は必須、かつユニークであることを保証
  validates :email, presence: true, uniqueness: true
end
