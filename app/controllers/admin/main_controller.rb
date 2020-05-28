class Admin::MainController < Admin::BaseController
  #skip_before_action :set_active_main_menu_item, except: :destroy



  def index
  end

  def set_active_main_menu_item
    @main_menu[:admin][:active] = true
  end

end
