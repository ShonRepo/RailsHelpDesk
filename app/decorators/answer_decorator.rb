class AnswerDecorator < ApplicationDecorator
  delegate_all

  def short_date
    created_at.strftime("%Y-%m-%d %H:%M:%S")
  end
end
