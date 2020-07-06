class Admin::AnswersController < ApplicationController
  before_action :set_ticket
  before_action :authenticate_admin!
  def index
    @Answers = @Ticket.answers.all
  end

  def create

    @Ticket.answers.create(answers_params)
    @Ticket[:answers][:sender] = current_admin.email
    if@Ticket.save
      redirect_to [:admin, @Ticket]
    else
      flash.now[:alert] = 'не удаось добавить ответ'
      redirect_to [:admin, @Ticket]
    end
  end

  private
  def set_ticket
    @Ticket = Ticket.find(params[:ticket_id])

  end

  def answers_params
    params.require(:answer).permit(:comment,:ticket_id,:sender)
  end

end
