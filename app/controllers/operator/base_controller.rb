# frozen_string_literal: true

# базовый контроллер оператора
class Operator::BaseController < ApplicationController
  layout 'operator'

  before_action :authenticate_operator!
  before_action :set_main_menu, except: :destroy
  before_action :set_current_operator
  before_action :set_active_main_menu_item, except: [:destroy, :indexthis, :new, :show, :create, :update, :create_stage]

  private
  
  # Загрузить данные текущего оператора
  def set_current_operator
    @Operator = Operator.find(current_operator.id)
  end

  # Загрузить данные меню
  def set_main_menu
    @main_menu = {  newticket: {name: I18n.t('ticket.new_ticket'), path: new_operator_ticket_path },
                    allticket: {name: I18n.t('ticket.available_ticket'),path: operator_tickets_path },
                    meticket: {name: I18n.t('ticket.all_my_ticket'), path: operator_indexthis_path } }
  end
end
