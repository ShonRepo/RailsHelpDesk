class Admin::StatusController < Admin::BaseController
  before_action :set_status, only: [:edit, :update, :destroy]
    add_breadcrumb "статусы", :admin_statuses_path



  def index
    @Status = Status.order(:name).page params[:page]
  end

  def new
      @Status = Status.new
      add_breadcrumb "новый статус", new_admin_status_path, title: 'Статусы'
  end

  def create
    @Status = Status.new(status_params)
    if@Status.save
      redirect_to admin_status_path, notice: 'Статус успешно создан'
    else
      add_breadcrumb "новый статус", new_admin_status_path, title: 'Статусы'
      flash.now[:alert] = 'не удаось создать статус'
      render :new
    end
  end

  def edit
    breadcrumb_update
  end

  def update
    if@Status.update(status_params)
      redirect_to admin_status_path, notice: 'статус успешно изменен'
    else
      breadcrumb_update
      flash.now[:alert] = 'не удалось изменить статус'
      render :edit
    end
  end

  def destroy
    if @Status.destroy
      redirect_to admin_status_path, notice: 'статус удален'
    else
      redirect_to admin_status_path, alert: 'не удалось'

    end
  end

  private

  def breadcrumb_update
    add_breadcrumb "изменить '#{@Status.name}'"  ,[:edit, :admin, @Status ]
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
