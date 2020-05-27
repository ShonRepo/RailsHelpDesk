class TypeDecorator < ApplicationDecorator
  delegate_all

  def type_number
    "#{id}.#{name}"
  end

end
