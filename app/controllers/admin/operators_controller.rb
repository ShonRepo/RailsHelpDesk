# frozen_string_literal: true

# Управление операторами
class Admin::OperatorsController < Admin::BaseController
  before_action :set_operator, only: [:edit, :update, :destroy]
  add_breadcrumb I18n.t('operator.operators'), :admin_operators_path

  # Все операторы постранично
  def index
    @Operators = Operator.where("id > 0").page params[:page]
  end

  # Страница нового оператора
  def new
      @Operator = Operator.new
      add_breadcrumb I18n.t('operator.new'), new_admin_operator_path, title: I18n.t('operator.operators')
  end

  # Добавить оператора
  def create
    @Operator = Operator.new(operator_params)

    if @Operator.save
      redirect_to admin_operators_path, notice: I18n.t('operator.created')
    else
      add_breadcrumb I18n.t('operator.new'), new_admin_operator_path, title: I18n.t('operator.operators')
      flash.now[:alert] = I18n.t('operator.do_not_created')
      render :new
    end
  end

  # Страница редактирования оператора
  def edit
    breadcrumb_update
  end

  # Обновить данные оператора
  def update
    if@Operator.update(operator_params)
      redirect_to admin_operators_path, notice: I18n.t('operator.updated')
    else
      breadcrumb_update
      flash.now[:alert] = I18n.t('operator.do_not_updated')
      render :edit
    end
  end

  # Удалить оператора
  def destroy
    if @Operator.destroy
      redirect_to admin_operators_path, notice: I18n.t('operator.deleted')
    else
      redirect_to admin_operators_path, alert: I18n.t('no_not')
    end
  end

  private

  # Обновить хлебные крошки
  def breadcrumb_update
    add_breadcrumb I18n.t('change_name', name: @Operator.decorate.full_name), [:edit, :admin, @Operator]
  end

  # Загрузить данные оператора
  def set_operator
    @Operator = Operator.find(params[:id])
  end

  # Выделить пункт меню
  def set_active_main_menu_item
    @main_menu[:operators][:active] = true
  end

  # Данные оператора
  def operator_params
    params.require(:operator).permit(:last_name, :email, :first_name, :password, :password_confirmation)
  end
end
