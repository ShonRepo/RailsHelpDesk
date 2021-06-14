# модель заявки
class Ticket < ApplicationRecord
  belongs_to :type
  belongs_to :operator
  belongs_to :status

  has_many :answers, dependent: :destroy

  has_many :tinymce_images, as: :owner, dependent: :destroy

  validates :title, presence: true
  validates :email, presence: true, format:
   {with: /\A[^@\s]+@[^@\s]+\z/, message: "проверьте формат"}
end
