# frozen_string_literal: true

# Ответы на заявку от оператора
class Operator::AnswersController < ApplicationController
  before_action :set_ticket
  before_action :authenticate_operator!

  # Отобразить все ответы по выбранной заявке
  def index
    @Answers = @Ticket.answers.all
  end

  # Отправить новый ответ
  def create
    @Answers = @Ticket.answers.create(answers_params)
    @Ticket[:status_id] = 3;
    @Answers[:sender] = current_operator.email
    if @Answers.save && @Ticket.save
      redirect_to [:operator, @Ticket]
    else
      flash.now[:alert] = I18n.t('answer.do_not_created')
      redirect_to [:operator, @Ticket]
    end
  end

  private

  # Подгрузить ответ
  def set_ticket
    @Ticket = Ticket.find(params[:ticket_id])

  end

  # Данные ответа
  def answers_params
    params.require(:answer).permit(:comment,:ticket_id,:sender)
  end

end
