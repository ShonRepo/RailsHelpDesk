# frozen_string_literal: true

# контроллер оператора
class Operator::OperatorsController < Operator::BaseController
  skip_before_action :set_active_main_menu_item
  add_breadcrumb I18n.t('login.my_data'), :edit_operator_operator_path

  # Страница изменений данных
  def edit
  end

  # Сохранить данные 
  def update
    if @Operator.update(operator_params)
      redirect_to operator_indexthis_path, notice: I18n.t('login.updated')
    else
      flash.now[:alert] = I18n.t('login.do_not_updated')
      render :edit
    end
  end

  private

  # Данные оператора
  def operator_params
    params.require(:operator).permit(:last_name, :email, :first_name, :password, :password_confirmation)
  end
end
