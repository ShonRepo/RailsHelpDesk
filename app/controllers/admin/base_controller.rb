class Admin::BaseController < ApplicationController
  layout 'admin'

  before_action :authenticate_admin!
  before_action :set_main_menu, except: :destroy
  before_action :set_active_main_menu_item, except: :destroy

  private
  def set_main_menu
    @main_menu = { tickets: {name: 'Заявки',path: admin_tickets_path },
               admins: {name: 'Администраторы',path: admin_admins_path},
              operators: {name: 'Операторы',path: admin_operators_path },
               types: {name: 'Типы',path: admin_types_path },
            statuses: {name: 'Статусы',path: admin_statuses_path }
          }
  end
end
