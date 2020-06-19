class Admin::AnswersController < ApplicationController
  before_action :set_ticket

  def index
    @Answers = @Ticket.answers.all
  end

  def create
    @Ticket.answers.create(answers_params)

    if@Ticket.save
      redirect_to [:admin, @Ticket]
    else
      flash.now[:alert] = 'не удаось добавить ответ'
      redirect_to [:admin, @Ticket]
    end
  end

  def destroy

  end

  private

  def set_ticket
    @Ticket = Ticket.find(params[:ticket_id])

  end

  def answers_params
    params.require(:answer).permit(:comment,:ticket_id)
  end

end
