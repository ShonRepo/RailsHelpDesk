class PagesController < BaseController

  # add_breadcrumb "Главная", :root_path

  def start
  end

  private

  def set_confirmed
    @Confirmed = Confirmed.find(params[:id])
  end

  def set_active_main_menu_item
    @main_menu[:main][:active] = true
  end

  def confirmed_params
    params.require(:confirmed).permit(:email,:active)
  end
end
