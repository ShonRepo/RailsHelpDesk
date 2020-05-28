class Ticket < ApplicationRecord
  belongs_to :type

  has_many :answers

  validates :title, presence: true
  validates :email, presence: true, format:
   {with: /\A[^@\s]+@[^@\s]+\z/, message: "проверьте формат"}
  validates :body, presence: true

end
