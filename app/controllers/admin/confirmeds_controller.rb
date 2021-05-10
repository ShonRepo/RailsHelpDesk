class Admin::ConfirmedsController < Admin::BaseController
  before_action :set_confirmed, only: [:edit, :update, :destroy,:switch]
  add_breadcrumb I18n.t('email.confirmed'), :admin_confirmeds_path



  def index
    @Confirmeds = Confirmed.order(enable: :desc).page params[:page]
  end

  def new
      @Confirmed = Confirmed.new
      add_breadcrumb I18n.t('email.add'), new_admin_confirmed_path, title: 'Email'
  end

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

  def switch
    @Confirmed[:enable] = !@Confirmed[:enable]
    if @Confirmed.save
      redirect_to admin_confirmeds_path, notice: I18n.t('email.change_status')
    else

      flash.now[:alert] = I18n.t('email.do_not_change_status')
      render :index
    end
  end

  def edit
    breadcrumb_update
  end

  def update
    if @Confirmed.update(confirmed_params)
      redirect_to admin_confirmeds_path, notice: I18n.t('email.updated')
    else
      breadcrumb_update
      flash.now[:alert] = I18n.t('email.do_not_updated')
      render :edit
    end
  end

  def destroy
    if @Confirmed.destroy
      redirect_to admin_confirmeds_path, notice: I18n.t('email.deleted')
    else
      redirect_to admin_confirmeds_path, alert: I18n.t('do_not')
    end
  end

  private

  def breadcrumb_update
    add_breadcrumb I18n.t('change_name', name: @Confirmed.email), [:edit, :admin, @Confirmed]
  end

  def set_confirmed
    @Confirmed = Confirmed.find(params[:id])
  end

  def set_active_main_menu_item
    @main_menu[:confirmeds][:active] = true
  end

  def confirmed_params
    params.require(:confirmed).permit(:email, :active)
  end
end
