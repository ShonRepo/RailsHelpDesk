class Admin::OperatorsController < Admin::BaseController
  before_action :set_operator, only: [:edit, :update, :destroy]
  add_breadcrumb "Операторы", :admin_operators_path

  def index
    @Operators = Operator.where("id > 0").page params[:page]
  end

  def new
      @Operator = Operator.new
      add_breadcrumb "новый Оператор", new_admin_operator_path, title: 'Операторы'
  end

  def create
    @Operator = Operator.new(operator_params)

    if@Operator.save
      redirect_to admin_operators_path, notice: 'Оператор успешно создан'
    else
      add_breadcrumb "новый Оператор", new_admin_operator_path, title: 'Операторы'
      flash.now[:alert] = 'не удалось создать Оператора'
      render :new
    end
  end



  def edit
    breadcrumb_update

  end

  def update
    if@Operator.update(operator_params)
      redirect_to admin_operators_path, notice: 'Оператор успешно изменен'
    else
      breadcrumb_update
      flash.now[:alert] = 'не удалось изменить Оператора'
      render :edit
    end
  end

  def destroy
    if @Operator.destroy
      redirect_to admin_operators_path, notice: 'Оператор удален'
    else
      redirect_to admin_operators_path, alert: 'не удалось'
    end
  end

  private

  def breadcrumb_update
    add_breadcrumb "изменить '#{@Operator.decorate.full_name}'"  , [:edit, :admin, @Operator ]
  end

  def set_operator
    @Operator = Operator.find(params[:id])
  end

  def set_active_main_menu_item
    @main_menu[:operators][:active] = true
  end

  def operator_params
    params.require(:operator).permit(:last_name,:email,:first_name,:password,:password_confirmation)
  end
end
