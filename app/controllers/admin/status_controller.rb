class Admin::StatusController < Admin::BaseController
  before_action :set_status, only: [:edit, :update, :destroy]
  add_breadcrumb I18n.t('status.statuses'), :admin_statuses_path

  def index
    @Status = Status.order(:name).page params[:page]
  end

  def new
    @Status = Status.new
    add_breadcrumb I18n.t('status.new_status'), new_admin_status_path, title: I18n.t('status.statuses')
  end

  def create
    @Status = Status.new(status_params)
    if@Status.save
      redirect_to admin_status_path, notice: I18n.t('status.status_created')
    else
      add_breadcrumb I18n.t('status.new_status'), new_admin_status_path, title: I18n.t('status.statuses')
      flash.now[:alert] = I18n.t('status.do_not_create_status')
      render :new
    end
  end

  def edit
    breadcrumb_update
  end

  def update
    if@Status.update(status_params)
      redirect_to admin_status_path, notice: I18n.t('status.status_updated')
    else
      breadcrumb_update
      flash.now[:alert] = I18n.t('status.do_not_update_status')
      render :edit
    end
  end

  def destroy
    if @Status.destroy
      redirect_to admin_status_path, notice: I18n.t('status.status_destroy')
    else
      redirect_to admin_status_path, alert: I18n.t('do_not')

    end
  end

  private

  def breadcrumb_update
    add_breadcrumb I18n.t('change_name:', name: @Status.name), [:edit, :admin, @Status]
  end

  def set_status
    @Status = Status.find(params[:id])
  end

  def set_active_main_menu_item
    @main_menu[:status][:active] = true
  end

  def status_params
    params.require(:status).permit(:name)
  end

end
