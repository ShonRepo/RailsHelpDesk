class Operator::TicketsController < Operator::BaseController
  before_action :set_ticket, only: [:edit, :update,:show, :create_stage,:take], except: :indexthis
  before_action :lock_ticket, only: [:edit,:show,:take]


  add_breadcrumb "Доступные заявки", :operator_tickets_path
  def index
    @Tickets = Ticket.where("operator_id = 0 or operator_id is null").order(updated_at: :desc).page params[:page]
  end

  def indexthis
    @Tickets = Ticket.where("operator_id = :me", {me: current_operator.id}).order(updated_at: :desc).page params[:page]
      if !params[:all]
        @Tickets = @Tickets.where("status_id != 4") .order(updated_at: :desc).page params[:page]
      end
    @main_menu[:meticket][:active] = true
    add_breadcrumb "Мои заявки", :operator_indexthis_path
  end

  def new
    @Ticket = Ticket.new
    @main_menu[:newticket][:active] = true
    add_breadcrumb "новая заявка", new_operator_ticket_path, title: 'Заявки'
  end

  def create
    if Ticket.where(ticket_params)
      @Ticket = Ticket.new(ticket_params)
      @Ticket[:uuid] = SecureRandom.hex(10)
      @Ticket[:operator_id] = current_operator.id;
      @Ticket[:status_id] = 2;
      if@Ticket.save
        redirect_to operator_stage_path(@Ticket), notice: 'Добавьте описание'
      else
        add_breadcrumb "новая заявка", new_operator_ticket_path, title: 'Заявки'
        flash.now[:alert] = 'не удаось создать заявку'
        @main_menu[:newticket][:active] = true
        render :new
      end
    else
      flash.now[:alert] = 'не удалось создать заявку'
      render :new
    end
  end

  def take
    add_breadcrumb "Принять заявку '#{@Ticket.title}'", operator_take_path, title: 'Заявки'
    if @Ticket[:operator_id] != 0
      redirect_to operator_indexthis_path, alert: 'Эта заявка уже принята'
    end
  end

  def create_stage
    @main_menu[:newticket][:active] = true
  end

  def show
    @main_menu[:meticket][:active] = true
    add_breadcrumb "Мои заявки", :operator_indexthis_path
  end

  def edit
  end

  def update
    if @Ticket[:operator_id] != current_operator.id
      @Ticket[:operator_id] = current_operator.id;
      @Ticket[:status_id] = 2;
    end
    if @Ticket.update!(ticket_params)
      redirect_to operator_ticket_path(@Ticket), notice: 'Заявка успешно изменена'
    else
      breadcrumb_update
      flash.now[:alert] = 'не удалось изменить заявку'
      render :edit
    end
  end

  private
  def set_ticket
    @Ticket = Ticket.find(params[:id])
  end

  def breadcrumb_update
    add_breadcrumb "изменить '#{@Ticket.title}'", [:edit, :admin, @Ticket ]
  end

  def set_active_main_menu_item
    @main_menu[:allticket][:active] = true
  end

  def lock_ticket
    if @Ticket[:operator_id] != 0 && @Ticket[:operator_id] != current_operator.id && @Ticket[:operator_id] != nil
      redirect_to operator_indexthis_path, alert: 'Нельзя получить сведения о заявке другого пользователя'
    end
  end

  def ticket_params
    params.require(:ticket).permit(:title,:email,:body,:type_id,:status_id,:operator_id)
  end
end
