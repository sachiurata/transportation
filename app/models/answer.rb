class Answer < ApplicationRecord
  belongs_to :subject, polymorphic: true
  belongs_to :question
  has_many :answer_options, dependent: :destroy
end
