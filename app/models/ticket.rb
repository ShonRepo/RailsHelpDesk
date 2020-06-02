class Ticket < ApplicationRecord
  belongs_to :type

  has_many :answers

  has_many :tinymce_images, as: :owner

  validates :title, presence: true
  validates :email, presence: true, format:
   {with: /\A[^@\s]+@[^@\s]+\z/, message: "проверьте формат"}
  

end
