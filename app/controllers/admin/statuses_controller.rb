# frozen_string_literal: true

# Управление статусами заявки
class Admin::StatusesController < Admin::BaseController
  before_action :set_status, only: [:edit, :update, :destroy]
  add_breadcrumb I18n.t('status.statuses'), :admin_statuses_path

  # Постраничный вывод статусов
  def index
    @Statuses = Status.order(:id).page params[:page]
  end

  # Сраница добавления статуса
  def new
      @Status = Status.new
      add_breadcrumb I18n.t('status.new_status'), new_admin_status_path, title: 'Статусы'
  end

  # Добавление статуса
  def create
    @Status = Status.new(status_params)
    if @Status.save
      redirect_to admin_statuses_path, notice: I18n.t('status.status_created')
    else
      add_breadcrumb I18n.t('status.new_status'), new_admin_status_path, title: 'Статусы'
      flash.now[:alert] = I18n.t('status.do_not_create_status')
      render :new
    end
  end

  # Страница изменения стаутса
  def edit
    breadcrumb_update
  end

  # обновить статус
  def update
    if @Status.update(status_params)
      redirect_to admin_statuses_path, notice: I18n.t('status.status_updated')
    else
      breadcrumb_update
      flash.now[:alert] = I18n.t('status.do_not_update_status')
      render :edit
    end
  end

  # Удалить статус
  def destroy
    if @Status.destroy
      redirect_to admin_statuses_path, notice: I18n.t('status.status_destroy')
    else
      redirect_to admin_statuses_path, alert: I18n.t('do_not')

    end
  end

  private

  # обновить хлебные крошки
  def breadcrumb_update
    add_breadcrumb I18n.t('change_name', name: @Status.name)  ,[:edit, :admin, @Status ]
  end

  # Обновить статус
  def set_status
    @Status = Status.find(params[:id])
  end

  # Выделить пункт в меню
  def set_active_main_menu_item
    @main_menu[:statuses][:active] = true
  end

  # Загрузить данные статуса
  def status_params
    params.require(:status).permit(:name)
  end
end
