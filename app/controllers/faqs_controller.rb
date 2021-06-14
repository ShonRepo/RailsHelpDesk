# frozen_string_literal: true

# ответы на популярные вопросы
class FaqsController < BaseController

  # Отобразить ответ и добавить кол-во посещений
  def show
    @faq = Faq.find(params[:id])
    @faq.update(count_reads: @faq.count_reads + 1)
    add_breadcrumb I18n.t('faqs.faq'), tickets_new_path, title: 'Заявки'
  end

  private

  # Выделить пункт в меню
  def set_active_main_menu_item
    @main_menu[:main][:active] = true
  end
end
