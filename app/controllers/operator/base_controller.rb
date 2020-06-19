class Operator::BaseController < ApplicationController
  layout 'operator'



  before_action :authenticate_operator!
  before_action :set_main_menu, except: :destroy
  before_action :set_active_main_menu_item, except: [:destroy, :indexthis]

  private
  def set_main_menu
    @main_menu = { allticket: {name: 'Доступные заявки',path: operator_tickets_path },
                    meticket: {name: 'Мои заявки',path: operator_indexthis_path } }

  end
end
