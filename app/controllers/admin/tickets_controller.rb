class Admin::TicketsController < Admin::BaseController
  before_action :set_ticket, only: [:edit, :update, :destroy,:show]
  add_breadcrumb "тикеты", :admin_tickets_path

  def index
    @Tickets = Ticket.order(updated_at: :desc).page params[:page]
  end

  def new
      @Ticket = Ticket.new
      add_breadcrumb "новый тикет", new_admin_ticket_path, title: 'Тикеты'
  end

  def create
    @Ticket = Ticket.new(ticket_params)
    @Ticket[:uuid] = SecureRandom.hex(10)
    if@Ticket.save
      redirect_to admin_tickets_path, notice: 'Тикет успешно создан'
    else
      add_breadcrumb "новый тикет", new_admin_ticket_path, title: 'Тикеты'
      flash.now[:alert] = 'не удаось создать тикет'
      render :new
    end
  end

  def show
    add_breadcrumb "'#{@Ticket.title}'"  , [ :admin, @Ticket ]
  end

  def edit
    breadcrumb_update

  end

  def update
    if@Ticket.update(ticket_params)
      redirect_to admin_tickets_path, notice: 'Тикет успешно изменен'
    else
      breadcrumb_update
      flash.now[:alert] = 'не удалось изменить тикет'
      render :edit
    end
  end

  def destroy
    if @Ticket.destroy
      redirect_to admin_tickets_path, notice: 'тикет удален'
    else
      redirect_to admin_tickets_path, alert: 'не удалось'

    end
  end

  private

  def breadcrumb_update
    add_breadcrumb "изменить '#{@Ticket.title}'"  , [:edit, :admin, @Ticket ]
  end

  def set_ticket
    @Ticket = Ticket.find(params[:id])
  end

  def set_active_main_menu_item
    @main_menu[:tickets][:active] = true
  end

  def ticket_params
    params.require(:ticket).permit(:title,:email,:body,:type_id)
  end
end
