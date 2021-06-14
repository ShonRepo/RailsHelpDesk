# frozen_string_literal: true

# базовый контроллер администратора
class Admin::BaseController < ApplicationController
  layout 'admin'

  before_action :authenticate_admin!
  before_action :set_main_menu, except: :destroy
  before_action :set_active_main_menu_item, except: :destroy

  private

  # Загрузить данные меню
  def set_main_menu
    @main_menu = { tickets: { name: I18n.t('ticket.tickets'), path: admin_tickets_path },
                   admins: { name: I18n.t('admin.admins'), path: admin_admins_path },
                   operators: { name: I18n.t('operator.operators'), path: admin_operators_path },
                   confirmeds: { name: I18n.t('email.confirmed'), path: admin_confirmeds_path },
                   faqs: { name: I18n.t('faqs.faqs'), path: admin_faqs_path },
                   types: { name: I18n.t('type.types'), path: admin_types_path },
                   statuses: { name: I18n.t('status.statuses'), path: admin_statuses_path } }
  end
end
