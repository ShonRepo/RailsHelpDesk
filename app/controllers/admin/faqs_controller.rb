# frozen_string_literal: true

# популярные ответы на вопросы
class Admin::FaqsController < Admin::BaseController
  before_action :set_faq, only: %i[show edit update destroy]
  add_breadcrumb I18n.t('faqs.faqs'), :admin_faqs_path
  # Все ответы на вопросы постранично
  def index
    @faqs = Faq.order(:title).page params[:page]
  end

  # отобразить ответ
  def show
    add_breadcrumb "'#{@faq.title}'", [:admin, @faq]
  end

  # Страница нового ответа
  def new
    @faq = Faq.new
  end

  # Создать ответ 
  def create
    @faq = Faq.new(faq_params())
    @faq.author = current_admin
    if @faq.save!
      redirect_to edit_admin_faq_path(@faq), notice: I18n.t('faqs.added')
    else
      add_breadcrumb I18n.t('faqs.add'), new_admin_faq_path, title: 'Faq'
      flash.now[:alert] = I18n.t('faqs.do_not_created')
      render :new
    end
  end

  # Страница редактирования ответа
  def edit
    breadcrumb_update
  end

  # Изменить ответ
  def update
    if @faq.update(faq_params())
      redirect_to admin_faqs_path, notice: I18n.t('faqs.updated')
    else
      add_breadcrumb I18n.t('faqs.update'), edit_admin_faq_path, title: 'Faq'
      flash.now[:alert] = I18n.t('faqs.do_not_updated')
      render :edit
    end
  end

  # Удалить ответ
  def destroy
    if @faq.destroy
      redirect_to admin_faqs_path, notice: I18n.t('faqs.delited_ticket')
    else
      redirect_to admin_faqs_path, alert: I18n.t('do_not')
    end
  end

  private

  # Обновить хлебные крошки
  def breadcrumb_update
    add_breadcrumb I18n.t('change_name', name: @faq.title), [:edit, :admin, @faq]
  end

  # Загрузить данные ответа
  def set_faq
    @faq = Faq.find(params[:id])
  end

  # Выделить пункт меню
  def set_active_main_menu_item
    @main_menu[:faqs][:active] = true
  end

  # Данные ответа
  def faq_params
    params.require(:faq).permit(:title, :text)
  end
end