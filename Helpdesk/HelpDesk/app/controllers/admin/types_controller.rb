class Admin::TypesController < Admin::BaseController
  before_action :set_type, only: [:edit, :update, :destroy]
  add_breadcrumb "типы", :admin_types_path



  def index
    @Types = Type.order(:name).page params[:page]
  end

  def new
      @Type = Type.new
      add_breadcrumb "новый тип", new_admin_type_path, title: 'Типы'
  end

  def create
    @Type = Type.new(type_params)
    if@Type.save
      redirect_to admin_types_path, notice: 'Тип успешно создан'
    else
      add_breadcrumb "новый тип", new_admin_type_path, title: 'Типы'
      flash.now[:alert] = 'не удаось создать тип'
      render :new
    end
  end

  def edit
    add_breadcrumb "изменить '#{@Type.name}'"  ,[:edit, :admin, @Type ]

  end

  def update
    if@Type.update(type_params)
      redirect_to admin_types_path, notice: 'тип успешно изменен'
    else
      add_breadcrumb "изменить '#{@Type.name}'"  , [:edit, :admin, @Type ]
      flash.now[:alert] = 'не удалось изменить тип'
      render :edit
    end
  end

  def destroy
    if @Type.destroy
      redirect_to admin_types_path, notice: 'тип удален'
    else
      redirect_to admin_types_path, alert: 'не удалось'

    end
  end

  private

  def set_type
    @Type = Type.find(params[:id])
  end

  def set_active_main_menu_item
    @main_menu[:types][:active] = true
  end

  def type_params
    params.require(:type).permit(:name)
  end
end
