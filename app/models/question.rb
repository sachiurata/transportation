class Question < ApplicationRecord
  has_many :question_options, dependent: :destroy
  has_many :answers, dependent: :destroy

  enum question_type: { multiple_choice: 0, free_text: 1, multiple_choice_and_free_text: 2 }
end
