class Admin::AdminsController < Admin::BaseController
  before_action :set_admin, only: [:edit, :update, :destroy]
  add_breadcrumb "Администраторы", :admin_admins_path

  def index
    @Admins = Admin.order(updated_at: :desc).page params[:page]
  end

  def new
      @Admin = Admin.new
      add_breadcrumb "новый Администратор", new_admin_admin_path, title: 'Администраторы'
  end

  def create
    @Admin = Admin.new(admin_params)

    if@Admin.save
      redirect_to admin_admins_path, notice: 'Администратор успешно создан'
    else
      add_breadcrumb "новый Администратор", new_admin_admin_path, title: 'Администраторы'
      flash.now[:alert] = 'не удаось создать Администратора'
      render :new
    end
  end



  def edit
    breadcrumb_update
  end

  def update
    if@Admin.update(admin_params)
      redirect_to admin_admins_path, notice: 'Администратор успешно изменен'
    else
      breadcrumb_update
      flash.now[:alert] = 'не удалось изменить Администратора'
      render :edit
    end
  end

  def destroy
    if @Admin.destroy
      redirect_to admin_admins_path, notice: 'Администратор удален'
    else
      redirect_to admin_admins_path, alert: 'не удалось'

    end
  end

  private

  def breadcrumb_update
    add_breadcrumb "изменить '#{@Admin.decorate.full_name}'"  , [:edit, :admin, @Admin ]
  end

  def set_admin
    @Admin = Admin.find(params[:id])
  end

  def set_active_main_menu_item
    @main_menu[:admins][:active] = true
  end

  def admin_params
    params.require(:admin).permit(:last_name,:email,:first_name,:password,:password_confirmation)
  end


end
