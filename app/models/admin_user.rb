class AdminUser < ApplicationRecord
  has_many :surveys, dependent: :destroy

  accepts_nested_attributes_for :surveys, allow_destroy: true
  # パスワードを安全に保存するための機能
  has_secure_password

  # user_nameの入力は必須、かつユニークであることを保証
  validates :user_name, presence: true, uniqueness: true

  # 管理者の権限設定
  enum :role, [ :superadmin, :editor, :viewer ]
end
