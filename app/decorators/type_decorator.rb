class TypeDecorator < ApplicationDecorator
  delegate_all

  def type_number
    "#{id}.#{name}"
  end

  def short_date
    updated_at.strftime("%Y-%m-%d %H:%M:%S")
  end
end
