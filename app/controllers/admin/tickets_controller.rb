class Admin::TicketsController < Admin::BaseController
  before_action :set_ticket, only: [:edit, :update, :destroy,:show, :create_stage,:take]
  add_breadcrumb "Заявки", :admin_tickets_path

  def index
    @Tickets = Ticket.order(updated_at: :desc).page params[:page]
  end

  def new
      @Ticket = Ticket.new
      add_breadcrumb I18n.t('ticket.new_ticket'), new_admin_ticket_path, title: 'Заявки'
  end

  def create
    if Ticket.where(ticket_params)
      @Ticket = Ticket.new(ticket_params)
      @Ticket[:uuid] = SecureRandom.hex(10)
      if@Ticket.save
        redirect_to admin_stage_path(@Ticket), notice: I18n.t('add_discription')
      else
        add_breadcrumb I18n.t('ticket.new_ticket'), new_admin_ticket_path, title: 'Заявки'
        flash.now[:alert] = I18n.t('ticket.do_not_create')
        render :new
      end
    else
      flash.now[:alert] = I18n.t('ticket.do_not_create')
      render :new
    end

  end

  def create_stage

  end

  def show
    add_breadcrumb "'#{@Ticket.title}'"  , [ :admin, @Ticket ]
  end

  def edit
    breadcrumb_update

  end

  def update
    if@Ticket.update!(ticket_params)
      redirect_to admin_tickets_path, notice: I18n.t('ticket.ticket_changed_successfully')
    else
      breadcrumb_update
      flash.now[:alert] = I18n.t('ticket.do_not_edit_ticket')
      render :edit
    end
  end

  def destroy
    if @Ticket.destroy
      redirect_to admin_tickets_path, notice: I18n.t('ticket.delited_ticket')
    else
      redirect_to admin_tickets_path, alert: I18n.t('do_not')

    end
  end

  private

  def breadcrumb_update
    add_breadcrumb I18n.t('status.statuses', name: @Ticket.title)  , [:edit, :admin, @Ticket ]
  end

  def set_ticket
    @Ticket = Ticket.find(params[:id])
  end

  def set_active_main_menu_item
    @main_menu[:tickets][:active] = true
  end

  def ticket_params
    params.require(:ticket).permit(:title,:email,:body,:type_id,:status_id,:operator_id)
  end
end
