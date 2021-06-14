# Готовые ответы на вопросы
class Faq < ApplicationRecord
  belongs_to :author, class_name: 'Admin',
                      foreign_key: :author_id

  has_many :tinymce_images, as: :owner, dependent: :destroy

  validates :title, presence: true
end
