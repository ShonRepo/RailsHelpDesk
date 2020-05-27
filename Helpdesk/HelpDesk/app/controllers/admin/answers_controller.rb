class Admin::AnswersController < ApplicationController
  before_action :set_ticket

  def index
    @Answers = @Ticket.answers.all
  end

  def create
    @Ticket.answers.create(answers_params)
  end

  def destroy

  end

  private

  def set_ticket
    @Ticket = Ticket.find(params[:ticket_id])

  end

  def answers_params
    params.require(:ticket).permit(:comment,:ticket_id)
  end

end
