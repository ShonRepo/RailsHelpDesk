class Admin < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable,:registerable, :recoverable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable,:trackable, :timeoutable,
          :rememberable, :validatable

  validates :last_name, presence: true
  validates :first_name, presence: true

  validates :email,  presence: true

  validates :password,  presence: true
  validates :password_confirmation, presence: true
end
