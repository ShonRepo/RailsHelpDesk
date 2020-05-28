class Admin::BaseController < ApplicationController
  layout 'admin'

  add_breadcrumb "админ", :admin_root_path

  before_action :authenticate_admin!
  before_action :set_main_menu, except: :destroy
  before_action :set_active_main_menu_item, except: :destroy

  private
  def set_main_menu
    @main_menu = { admin: {name: 'Главная',path: admin_root_path },
              tickets: {name: 'Тикеты',path: admin_tickets_path },
               types: {name: 'Типы',path: admin_types_path },
             admins: {name: 'Администраторы',path: admin_admins_path }}
  end
end
