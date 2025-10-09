class Child < ApplicationRecord
  belongs_to :user
  has_many :answers, as: :subject, dependent: :destroy
  has_many :requested_routes, as: :subject, dependent: :destroy

  validates :school_type, presence: true
  validates :grade, presence: true

  enum :school_type, { elementary: 0, secondary: 1, high: 2 }

  SCHOOL_NAMES = [
    "佐沼小学校",
    "新田小学校",
    "北方小学校",
    "登米小学校",
    "東和小学校",
    "石森小学校",
    "加賀野小学校",
    "宝江小学校",
    "加賀野小学校",
    "宝江小学校",
    "上沼小学校",
    "浅水小学校",
    "豊里小・中学校",
    "中津山小学校",
    "米岡小学校",
    "米山東小学校",
    "石越小学校",
    "南方小学校",
    "西郷小学校",
    "東郷小学校",
    "津山小学校",
    "佐沼中学校",
    "新田中学校",
    "登米中学校",
    "東和中学校",
    "中田中学校",
    "米山中学校",
    "石越中学校",
    "南方中学校",
    "津山中学校"
  ]
end
