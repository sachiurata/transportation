class QuestionOption < ApplicationRecord
  belongs_to :question
  has_many :answer_options, dependent: :destroy
end
