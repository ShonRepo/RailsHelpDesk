# frozen_string_literal: true

# Контроллер главной страницы
class Admin::MainController < Admin::BaseController

  # Главная страница
  def index
  end

  # Выделить пункт меню
  def set_active_main_menu_item
    @main_menu[:admin][:active] = true
  end
end
