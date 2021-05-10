class BaseController < ApplicationController
  add_breadcrumb I18n.t('main'), :root_path
  before_action :set_main_menu, except: :destroy
  before_action :set_active_main_menu_item, except: :destroy

  private
  def set_main_menu
    @main_menu = {  main: {name: I18n.t('main'), path: root_path },
                    newticket: {name: I18n.t('ticket.create_ticket'), path: tickets_new_path },
                    myticket: {name: I18n.t('ticket.show_ticket'), path: tickets_index_path } }
  end
end
