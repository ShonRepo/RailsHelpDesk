# frozen_string_literal: true

# Контроллер главного меню пользователя
class PagesController < BaseController
  # Стартовая страница
  def start
    @faqs = Faq.order(count_reads: :desc).page params[:page]
  end

  private

  # Выделить пункт в меню
  def set_active_main_menu_item
    @main_menu[:main][:active] = true
  end
end
