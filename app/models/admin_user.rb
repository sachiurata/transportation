class AdminUser < ApplicationRecord
  # パスワードを安全に保存するための機能
  has_secure_password

  # emailの入力は必須、かつユニークであることを保証
  validates :email, presence: true, uniqueness: true

  # 管理者の権限設定
  enum role: { general: 0 }
end
