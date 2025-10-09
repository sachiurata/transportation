class User < ApplicationRecord
  has_one :user_profile, dependent: :destroy
  has_many :children, dependent: :destroy
  accepts_nested_attributes_for :user_profile
  accepts_nested_attributes_for :children, allow_destroy: true

  # パスワードを安全に保存するための機能
  has_secure_password

  # user_nameの入力は必須、かつユニークであることを保証
  validates :user_name, presence: true, uniqueness: true
end
