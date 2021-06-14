# frozen_string_literal: true

# Контроллер управления администраторов
class Admin::AdminsController < Admin::BaseController
  before_action :set_admin, only: %i[edit update destroy]
  add_breadcrumb I18n.t('admin.admins'), :admin_admins_path

  # Отображение всех администраторов постранично
  def index
    @Admins = Admin.order(updated_at: :desc).page params[:page]
  end

  # Страница для добавления нового администратора
  def new
    @Admin = Admin.new
    add_breadcrumb I18n.t('admin.new'), new_admin_admin_path, title: I18n.t('admin.admins')
  end

  # Добавление нового администратора
  def create
    @Admin = Admin.new(admin_params)

    if @Admin.save
      redirect_to admin_admins_path, notice: I18n.t('admin.created')
    else
      add_breadcrumb I18n.t('admin.new'), new_admin_admin_path, title: I18n.t('admin.admins')
      flash.now[:alert] = I18n.t('admin.do_not_created')
      render :new
    end
  end

  # Переход на страницу редактирования администратора
  def edit
    breadcrumb_update
  end

  # Обновить данные администратора
  def update
    if @Admin.update(admin_params)
      redirect_to admin_admins_path, notice: I18n.t('admin.updated')
    else
      breadcrumb_update
      flash.now[:alert] = I18n.t('admin.do_not_updated')
      render :edit
    end
  end
  
  # Удалить администратора
  def destroy
    if @Admin.destroy
      redirect_to admin_admins_path, notice: I18n.t('admin.deleted')
    else
      redirect_to admin_admins_path, alert: I18n.t('do_not')
    end
  end

  private

  # Обновить хлебные крошки
  def breadcrumb_update
    add_breadcrumb I18n.t('change_name', name: @Admin.decorate.full_name), [:edit, :admin, @Admin]
  end

  # Подгрузка данных администратора
  def set_admin
    @Admin = Admin.find(params[:id])
  end

  # Выделить текущий пункт меню
  def set_active_main_menu_item
    @main_menu[:admins][:active] = true
  end

  # Данные администратора
  def admin_params
    params.require(:admin).permit(:last_name,:email,:first_name,:password,:password_confirmation)
  end
end
