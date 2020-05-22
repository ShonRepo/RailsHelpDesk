class Admin::TicketsController < Admin::BaseController
  def show
  end

  def index
    @Tickets = Ticket.all
  end

  def new
      @Ticket = Ticket.new
  end

  def create
    @Ticket = Ticket.new(ticket_params)
  
    if@Ticket.save
      redirect_to admin_tickets_path, notice: 'Тикет успешно создал'
    else
      flash.now[:alert] = 'Ошибка'
      render :new
    end
  end

  def edit
  end

  def update
  end

  def destroy
  end

  private
  def set_active_main_menu_item
    @main_menu[:tickets][:active] = true
  end

  def ticket_params
    params.require(:ticket).permit(:title,:email,:body)
  end
end
