class TicketDecorator < ApplicationDecorator
  delegate_all

  def short_date
    updated_at.strftime("%Y-%m-%d %H:%M:%S")
  end

end
