class Admin::ConfirmedsController < Admin::BaseController
  before_action :set_confirmed, only: [:edit, :update, :destroy,:switch]
  add_breadcrumb "Подтвержденные email", :admin_confirmeds_path



  def index
    @Confirmeds = Confirmed.order(enable: :desc).page params[:page]
  end

  def new
      @Confirmed = Confirmed.new
      add_breadcrumb "Добавление email", new_admin_confirmed_path, title: 'Email'
  end

  def create
    @Confirmed = Confirmed.new(confirmed_params)
    @Confirmed[:enable] = true
    if@Confirmed.save
      redirect_to admin_confirmeds_path, notice: 'Email успешно добавлен'
    else
      add_breadcrumb "Добавление email", new_admin_confirmed_path, title: 'Email'
      flash.now[:alert] = 'не удалось добавить email'
      render :new
    end
  end

  def switch
    @Confirmed[:enable] = !@Confirmed[:enable]
    if@Confirmed.save
      redirect_to admin_confirmeds_path, notice: "Статус email'а успешно изменен"
    else

      flash.now[:alert] = "не удалось изменить статус email'а"
      render :index
    end
  end

  def edit
    breadcrumb_update
  end

  def update
    if@Confirmed.update(confirmed_params)
      redirect_to admin_confirmeds_path, notice: 'email успешно изменен'
    else
      breadcrumb_update
      flash.now[:alert] = 'не удалось изменить email'
      render :edit
    end
  end

  def destroy
    if @Confirmed.destroy
      redirect_to admin_confirmeds_path, notice: 'email удален'
    else
      redirect_to admin_confirmeds_path, alert: 'не удалось'

    end
  end

  private

  def breadcrumb_update
    add_breadcrumb "изменить '#{@Confirmed.email}'"  ,[:edit, :admin, @Confirmed]
  end

  def set_confirmed
    @Confirmed = Confirmed.find(params[:id])
  end

  def set_active_main_menu_item
    @main_menu[:confirmeds][:active] = true
  end

  def confirmed_params
    params.require(:confirmed).permit(:email,:active)
  end

end
