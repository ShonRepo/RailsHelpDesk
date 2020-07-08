class Operator::AnswersController < ApplicationController
  before_action :set_ticket
  before_action :authenticate_operator!
  def index
    @Answers = @Ticket.answers.all
  end

  def create

    @Answers = @Ticket.answers.create(answers_params)
    @Ticket[:status_id] = 3;
    @Answers[:sender] = current_operator.email
    if @Answers.save && @Ticket.save
      redirect_to [:operator, @Ticket]
    else
      flash.now[:alert] = 'не удаось добавить ответ'
      redirect_to [:operator, @Ticket]
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
