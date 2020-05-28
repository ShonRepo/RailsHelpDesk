class Answer < ApplicationRecord
  belongs_to :ticket

  validates :comment, presence: true
end
