class Ticket < ApplicationRecord
  validates :title, presence: true
  validates :email, presence: true
  validates :body, presence: true
end
