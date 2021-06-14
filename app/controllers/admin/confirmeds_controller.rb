# frozen_string_literal: true

# Подтвержденные email 
class Admin::ConfirmedsController < Admin::BaseController
  before_action :set_confirmed, only: [:edit, :update, :destroy,:switch]
  add_breadcrumb I18n.t('email.confirmed'), :admin_confirmeds_path

  # Все подтвержденные email с пагинацией
  def index
    @Confirmeds = Confirmed.order(enable: :desc).page params[:page]
  end

  # переход на добавление нового email 
  def new
      @Confirmed = Confirmed.new
      add_breadcrumb I18n.t('email.add'), new_admin_confirmed_path, title: 'Email'
  end

  # Добавление email
  def create
    @Confirmed = Confirmed.new(confirmed_params)
    @Confirmed[:enable] = true
    if @Confirmed.save
      redirect_to admin_confirmeds_path, notice: 'Email успешно добавлен'
    else
      add_breadcrumb I18n.t('email.add'), new_admin_confirmed_path, title: 'Email'
      flash.now[:alert] = I18n.t('email.do_not_created')
      render :new
    end
  end

  # переключения доступа к email
  def switch
    @Confirmed[:enable] = !@Confirmed[:enable]
    if @Confirmed.save
      redirect_to admin_confirmeds_path, notice: I18n.t('email.change_status')
    else
      flash.now[:alert] = I18n.t('email.do_not_change_status')
      render :index
    end
  end

  # Переход на редактирование добавленного email
  def edit
    breadcrumb_update
  end

  # Обновить данные email
  def update
    if @Confirmed.update(confirmed_params)
      redirect_to admin_confirmeds_path, notice: I18n.t('email.updated')
    else
      breadcrumb_update
      flash.now[:alert] = I18n.t('email.do_not_updated')
      render :edit
    end
  end

  # Удалить email 
  def destroy
    if @Confirmed.destroy
      redirect_to admin_confirmeds_path, notice: I18n.t('email.deleted')
    else
      redirect_to admin_confirmeds_path, alert: I18n.t('do_not')
    end
  end

  private

  # Обновить хлебные крошки
  def breadcrumb_update
    add_breadcrumb I18n.t('change_name', name: @Confirmed.email), [:edit, :admin, @Confirmed]
  end

  # Выбрать email 
  def set_confirmed
    @Confirmed = Confirmed.find(params[:id])
  end

  # выбделить раздел в меню 
  def set_active_main_menu_item
    @main_menu[:confirmeds][:active] = true
  end

  # Данные email 
  def confirmed_params
    params.require(:confirmed).permit(:email, :active)
  end
end
