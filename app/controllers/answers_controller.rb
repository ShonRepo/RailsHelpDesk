# frozen_string_literal: true

# Ответы на заявку от пользователя
class AnswersController < ApplicationController
  before_action :set_ticket
  
  # Отобразить все ответы по выбранной заявке
  def index
    @Answers = @Ticket.answers.all
  end

  # Отправить новый ответ
  def create
    @Answers = @Ticket.answers.create(answers_params)
    @Answers[:sender] = @Ticket.email
    @Ticket.update(status_id: 2)
    if @Answers.save
      redirect_to [@Ticket]
    else
      flash.now[:alert] = I18n.t('answer.do_not_created')
      redirect_to [@Ticket]
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
