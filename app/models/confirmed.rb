class Confirmed < ApplicationRecord
  validates :email, presence: true, format:
   {with: /\A[^@\s]+@[^@\s]+\z/, message: "проверьте формат"}
end
