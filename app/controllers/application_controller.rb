# frozen_string_literal: true

# Основной контроллер приложения 
class ApplicationController < ActionController::Base
  before_action :set_locale

  # Установить локаль
  def set_locale
    I18n.locale = params[:locale] || session[:locale] || I18n.default_locale
    session[:locale] = I18n.locale
  end

  # Стандартное значение локали
  def default_url_options
    { locale: I18n.locale }
  end
end
