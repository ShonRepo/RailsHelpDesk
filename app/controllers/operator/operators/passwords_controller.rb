# frozen_string_literal: true

# Смена пароля опеатора
class Operator::Operators::PasswordsController < Devise::PasswordsController
  layout 'operator'
end
