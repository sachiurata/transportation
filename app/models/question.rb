class Question < ApplicationRecord
  belongs_to :survey
  has_many :question_options, dependent: :destroy
  # question_options_attributes という名前でデータを受け取ることを許可する
  accepts_nested_attributes_for :question_options, reject_if: :all_blank, allow_destroy: true

  has_many :answers, dependent: :destroy

  enum :question_type, { multiple_choice: 0, free_text: 1, multiple_choice_and_free_text: 2 }

  validates :text, presence: true
  validates :question_type, presence: true
end
