# frozen_string_literal: true

# Загруженные изображения
class TinymceImagesController < ApplicationController
  respond_to :json

  # Добавить картинку
  def create
    image = TinymceImage.new(tinymce_image_params)
    image.owner = owner

    if image.save
      render json: { image: { url: image.file.url } }, content_type: "text/html"
    else
      render json: { error: { message: image.errors.full_messages.join(', ') } }, content_type: "text/html"
    end
  end

  private

  # Файл картинки
  def tinymce_image_params
    params.permit(:file)
  end

  # источник отправки файла
  def owner
    @owner ||= params[:owner].capitalize.constantize.find(params["#{params[:owner]}_id".to_sym])
  end
end
