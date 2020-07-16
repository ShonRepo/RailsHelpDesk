class BaseController < ApplicationController

  before_action :set_main_menu, except: :destroy
  before_action :set_active_main_menu_item, except: :destroy

  private
  def set_main_menu
    @main_menu = {  main: {name: 'Главная',path: root_path },
                    newticket: {name: 'Создать заявку',path: root_path },
                    myticket: {name: 'Просмотр заявки',path: root_path } }
  end
end
