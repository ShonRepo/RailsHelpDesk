# frozen_string_literal: true

# Управление заявками
class TicketsController < BaseController
  skip_before_action :set_active_main_menu_item, except: :destroy
  before_action :set_ticket, only: [ :edit, :update, :destroy, :show, :create_stage]
  before_action :lock_ticket, only: [ :show, :edit, :update ]
  
  # Страница поиска заявок
  def index
    add_breadcrumb I18n.t('ticket.search_my_ticket'), :tickets_index_path
    @main_menu[:myticket][:active] = true
  end

  # Переход на найденную заявку
  def search
    @Ticket = Ticket.find_by(uuid: params[:search])
      if @Ticket.present?
        cookies[:id] = @Ticket[:id]
        redirect_to tickets_show_path(@Ticket)
      else
        flash.now[:alert] = I18n.t('ticket.ticket_do_not_exist')
        render :index
      end
  end

  # Страница добавления новой заявки
  def new
    @Ticket = Ticket.new
    @main_menu[:newticket][:active] = true
    add_breadcrumb I18n.t('ticket.new_ticket'), tickets_new_path, title: 'Заявки'
  end

  # Отобразить заявку
  def show
    @main_menu[:myticket][:active] = true
    add_breadcrumb I18n.t('ticket.search_my_ticket'), :tickets_index_path
    add_breadcrumb I18n.t('ticket.my_ticket'), :tickets_show_path
  end

  # Второй шаг добавления заявки
  def create_stage
    @main_menu[:newticket][:active] = true
  end

  # Страница редактирования заявки
  def edit
    breadcrumb_update
  end

  # Добавить заявку
  def create
    if Ticket.where(ticket_params)
      @Ticket = Ticket.new(ticket_params)
      @Ticket[:uuid] = SecureRandom.hex(10)
      @Ticket[:operator_id] = 0
      @Ticket[:status_id] = 2

      if Confirmed.find_by(email: ticket_params[:email], enable: true).present?
        if @Ticket.save
          cookies[:id] = @Ticket.id
          redirect_to stage_path(@Ticket), notice: I18n.t('add_discription')
        else
          add_breadcrumb I18n.t('ticket.new_ticket'), tickets_new_path, title: 'Заявки'
          flash.now[:alert] = I18n.t('ticket.do_not_create')
          @main_menu[:newticket][:active] = true
          render :new
        end
      else
        flash.now[:alert] = I18n.t('ticket.email_not_in_white_list')
        render :new
      end
    else
      flash.now[:alert] = I18n.t('ticket.do_not_create')
      render :new
    end
  end

  # Изменить данные заявки
  def update
    if @Ticket.update(ticket_params)
      redirect_to ticket_path(@Ticket), notice: I18n.t('ticket.ticket_changed_successfully')
    else
      breadcrumb_update
      flash.now[:alert] = I18n.t('ticket.do_not_edit_ticket')
      render :edit
    end
  end

  private

  # Обновить хлебные крошки
  def breadcrumb_update
    add_breadcrumb I18n.t('change_name', name: @Ticket.title), [:edit, :admin, @Ticket]
  end

  # Загрузить заявку
  def set_ticket
    @Ticket = Ticket.find(params[:id])
  end

  # Заблокировать заявку
  def lock_ticket
    if cookies[:id] != params[:id]
      redirect_to root_path, alert: I18n.t('ticket.this_not_your_ticket')
    end
  end

  # Выделить пункт меню
  def set_active_main_menu_item
    @main_menu[:tickets][:active] = true
  end

  # Данные заявки
  def ticket_params
    params.require(:ticket).permit(:title, :email, :body, :type_id, :status_id, :operator_id)
  end
end
