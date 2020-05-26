class Ticket < ApplicationRecord
  validates :title, presence: true
  validates :email, presence: true, format:
   {with: /\A[^@\s]+@[^@\s]+\z/, message: "проверьте формат"}
  validates :body, presence: true
  
end
