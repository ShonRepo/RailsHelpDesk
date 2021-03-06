# frozen_string_literal: true

# Тип заявки
class Admin::TypesController < Admin::BaseController
  before_action :set_type, only: [:edit, :update, :destroy]
  add_breadcrumb I18n.t('type.types'), :admin_types_path

  # Все типы постранично
  def index
    @Types = Type.order(:name).page params[:page]
  end

  # Страница добавления нового типа
  def new
      @Type = Type.new
      add_breadcrumb I18n.t('type.new'), new_admin_type_path, title: I18n.t('type.types')
  end

  # Создать новый тип
  def create
    @Type = Type.new(type_params)
    if @Type.save
      redirect_to admin_types_path, notice: I18n.t('type.created')
    else
      add_breadcrumb I18n.t('type.new'), new_admin_type_path, title: I18n.t('type.types')
      flash.now[:alert] = I18n.t('type.do_not_created')
      render :new
    end
  end

  # Открыть сраницу редактирования типа
  def edit
    breadcrumb_update
  end

  # Изменить данные типа 
  def update
    if@Type.update(type_params)
      redirect_to admin_types_path, notice: I18n.t('type.updated')
    else
      breadcrumb_update
      flash.now[:alert] = I18n.t('type.do_not_updated')
      render :edit
    end
  end

  # удалить тип
  def destroy
    if @Type.destroy
      redirect_to admin_types_path, notice: I18n.t('type.deleted')
    else
      redirect_to admin_types_path, alert: I18n.t('do_not')

    end
  end

  private

  # Обновление хлебных крошек
  def breadcrumb_update
    add_breadcrumb I18n.t('change_name', name: @Type.name), [:edit, :admin, @Type]
  end

  # Загрузить тип
  def set_type
    @Type = Type.find(params[:id])
  end

  # Выделить меню
  def set_active_main_menu_item
    @main_menu[:types][:active] = true
  end

  # Данные типа
  def type_params
    params.require(:type).permit(:name)
  end
end
