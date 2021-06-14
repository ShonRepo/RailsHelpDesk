# frozen_string_literal: true

# Контроллер заявки
class Operator::TicketsController < Operator::BaseController
  before_action :set_ticket, only: [:edit, :update,:show, :create_stage,:take], except: :indexthis
  before_action :lock_ticket, only: [:edit,:show,:take]
  add_breadcrumb I18n.t('ticket.available_ticket'), :operator_tickets_path

  # Постраничный вывод заявок 
  def index
    @Tickets = Ticket.where("operator_id = 0 or operator_id is null").order(updated_at: :desc).page params[:page]
  end

  # Заявки текущего оператора
  def indexthis
    @Tickets = Ticket.where("operator_id = :me", { me: current_operator.id }).order(updated_at: :desc).page params[:page]
      if !params[:all]
        @Tickets = @Tickets.where("status_id != 4").order(updated_at: :desc).page params[:page]
      end
    @main_menu[:meticket][:active] = true
    add_breadcrumb I18n.t('ticket.all_my_ticket'), :operator_indexthis_path
  end

  # Страница добавления новой заявки
  def new
    @Ticket = Ticket.new
    @main_menu[:newticket][:active] = true
    add_breadcrumb I18n.t('ticket.new_ticket'), new_operator_ticket_path, title: I18n.t('ticket.tickets')
  end

  # Добавить заявку
  def create
    if Ticket.where(ticket_params)
      @Ticket = Ticket.new(ticket_params)
      @Ticket[:uuid] = SecureRandom.hex(10)
      @Ticket[:operator_id] = current_operator.id
      @Ticket[:status_id] = 2
      if @Ticket.save
        redirect_to operator_stage_path(@Ticket), notice: I18n.t('add_discription')
      else
        add_breadcrumb I18n.t('ticket.new_ticket'), new_operator_ticket_path, title: I18n.t('ticket.tickets')
        flash.now[:alert] = I18n.t('ticket.do_not_create')
        @main_menu[:newticket][:active] = true
        render :new
      end
    else
      flash.now[:alert] = I18n.t('ticket.do_not_create')
      render :new
    end
  end

  # Взять заявку
  def take
    add_breadcrumb  I18n.t('ticket.accept_ticket', name: @Ticket.title), operator_take_path, title: I18n.t('ticket.tickets')
    if @Ticket[:operator_id] != 0
      redirect_to operator_indexthis_path, alert: I18n.t('ticket.this_ticket_accepted')
    end
  end

  # Второй шаг добавления заявки
  def create_stage
    @main_menu[:newticket][:active] = true
  end

  # Отобразить заявку
  def show
    add_breadcrumb I18n.t('ticket.all_my_ticket'), :operator_indexthis_path
    add_breadcrumb I18n.t('ticket.ticket', name: @Ticket.title), :operator_ticket_path
    @main_menu[:allticket][:active] = true
  end

  # Страница редактирования заявки
  def edit
    add_breadcrumb I18n.t('ticket.all_my_ticket'), :operator_indexthis_path
    add_breadcrumb I18n.t('ticket.edit_ticket_name', name: @Ticket.title), :edit_operator_ticket_path
    @main_menu[:allticket][:active] = true
  end

  # Изменить данные заявки
  def update
    if @Ticket[:operator_id] != current_operator.id
      @Ticket[:operator_id] = current_operator.id;
      @Ticket[:status_id] = 2;
    end
    if @Ticket.update(ticket_params)
      redirect_to operator_ticket_path(@Ticket), notice: I18n.t('ticket.ticket_changed_successfully')
    else
      breadcrumb_update
      flash.now[:alert] = I18n.t('ticket.do_not_edit_ticket')
      render :edit
    end
  end

  private

  # Загрузить заявку
  def set_ticket
    @Ticket = Ticket.find(params[:id])
  end

  # Обновить хлебные крошки
  def breadcrumb_update
    add_breadcrumb I18n.t('change_name', name: @Ticket.title), [:edit, :admin, @Ticket]
  end

  # Выделить пункт меню
  def set_active_main_menu_item
    @main_menu[:allticket][:active] = true
  end

  # Ограничить переход по заявке
  def lock_ticket
    if @Ticket[:operator_id] != 0 && @Ticket[:operator_id] != current_operator.id && !@Ticket[:operator_id].nil?
      redirect_to operator_indexthis_path, alert: I18n.t('ticket.not_my_ticket')
    end
  end

  # Данные заявки
  def ticket_params
    params.require(:ticket).permit(:title, :email, :body, :type_id, :status_id, :operator_id)
  end
end
