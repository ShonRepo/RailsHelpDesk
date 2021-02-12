class TicketsController < BaseController
  skip_before_action :set_active_main_menu_item, except: :destroy
  before_action :set_ticket, only: [ :edit, :update, :destroy, :show, :create_stage]
  before_action :lock_ticket, only: [ :show, :edit, :update ]
  def index
    add_breadcrumb "Найти мою заявку", :tickets_index_path
    @main_menu[:myticket][:active] = true
  end

  def search
    @Ticket = Ticket.where("uuid = :uuid", {uuid: params[:search]})
      if @Ticket.count() > 0
        cookies[:id] = @Ticket.first[:id]
        redirect_to tickets_show_path(@Ticket.first)
      else
        flash.now[:alert] = 'Такой заявки не существует'
        render :index
      end
  end

  def new
    @Ticket = Ticket.new
    @main_menu[:newticket][:active] = true
    add_breadcrumb "новая заявка", tickets_new_path, title: 'Заявки'
  end

  def show
    @main_menu[:myticket][:active] = true
    add_breadcrumb "Найти мою заявку", :tickets_index_path
    add_breadcrumb "Моя заявка", :tickets_show_path
  end

  def create_stage
    @main_menu[:newticket][:active] = true
  end

  def edit

  end

  def create
    if Ticket.where(ticket_params)
      @Ticket = Ticket.new(ticket_params)
      @Ticket[:uuid] = SecureRandom.hex(10)
      @Ticket[:operator_id] = 0;
      @Ticket[:status_id] = 2;

      if @Ticket.save
        cookies[:id] = @Ticket.id 
        redirect_to stage_path(@Ticket), notice: 'Добавьте описание'
      else
        add_breadcrumb "новая заявка", tickets_new_path, title: 'Заявки'
        flash.now[:alert] = 'не удаось создать заявку'
        @main_menu[:newticket][:active] = true
        render :new
      end
    else
      flash.now[:alert] = 'не удалось создать заявку'
      render :new
    end
  end

  def update
    if @Ticket.update(ticket_params)
      redirect_to ticket_path(@Ticket), notice: 'Заявка успешно изменена'
    else
      breadcrumb_update
      flash.now[:alert] = 'не удалось изменить заявку'
      render :edit
    end
  end

  private

  def breadcrumb_update
    add_breadcrumb "изменить '#{@Ticket.title}'"  , [:edit, :admin, @Ticket ]
  end

  def set_ticket
    @Ticket = Ticket.find(params[:id])

  end

  def lock_ticket
    if cookies[:id] != params[:id]
      redirect_to root_path, alert: 'Это не ваша заявка'
    end
  end

  def set_active_main_menu_item
    @main_menu[:tickets][:active] = true
  end

  def ticket_params
    params.require(:ticket).permit(:title,:email,:body,:type_id,:status_id,:operator_id)
  end

end
