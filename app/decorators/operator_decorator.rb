class OperatorDecorator < ApplicationDecorator
  delegate_all

  def full_name
    "#{first_name} #{last_name}"
  end



end
