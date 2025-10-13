class AdminUser < ApplicationRecord
  # パスワードを安全に保存するための機能
  has_secure_password

  # emailの入力は必須、かつユニークであることを保証
  validates :email, presence: true, uniqueness: true
  validates :role, presence: true

  # 管理者の権限設定（最低2つ以上の値を定義）
  enum role: { general: 0, superadmin: 1 }
end
