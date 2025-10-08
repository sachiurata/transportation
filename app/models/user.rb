class User < ApplicationRecord
  has_many :requested_routes, dependent: :destroy

  # パスワードを安全に保存するための機能
  has_secure_password

  # user_nameの入力は必須、かつユニークであることを保証
  validates :user_name, presence: true, uniqueness: true
end
