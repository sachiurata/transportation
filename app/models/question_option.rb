class QuestionOption < ApplicationRecord
  belongs_to :question
  has_many :answer_options, dependent: :destroy
  has_many :answers, through: :answer_options
  validates :text, presence: true
end
