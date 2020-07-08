class Operator::OperatorsController < Operator::BaseController

  skip_before_action :set_active_main_menu_item
  add_breadcrumb "Мои данные", :edit_operator_operator_path

  def edit

  end

  def update
    if@Operator.update(operator_params)
      redirect_to operator_indexthis_path, notice: 'Ваши данные успешно изменены'
    else
      flash.now[:alert] = 'Не удалось изменить ваши данные'
      render :edit
    end
  end


  private
  def operator_params
    params.require(:operator).permit(:last_name,:email,:first_name,:password,:password_confirmation)
  end
end
