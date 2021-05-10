class Admin::AnswersController < ApplicationController
  before_action :set_ticket
  before_action :authenticate_admin!
  def index
    @Answers = @Ticket.answers.all
  end

  def create
    @Answers = @Ticket.answers.create(answers_params)
    @Answers[:sender] = current_admin.email
    if @Answers.save
      redirect_to [:admin, @Ticket]
    else
      flash.now[:alert] = I18n.t('admin.do_not_created')
      redirect_to [:admin, @Ticket]
    end
  end

  private

  def set_ticket
    @Ticket = Ticket.find(params[:ticket_id])
  end

  def answers_params
    params.require(:answer).permit(:comment, :ticket_id, :sender)
  end
end
