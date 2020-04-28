# frozen_string_literal: true

class SettingsPage < SitePrism::Page
  set_url ''

  element :input_name, '#user_name'
  element :input_email, '#user_email'
  element :input_password, '#user_password'
  element :input_password_confirmation, '#user_password_confirmation'
  element :button_save_changes, :xpath, '//input[@value="Save changes"]'

  def preencher_dados_usuario(**attrs)
    input_name.set attrs[:input_name]
    input_email.set attrs[:input_email]
    input_password.set attrs[:input_password]
    input_password_confirmation.set attrs[:input_password_confirmation]
  end

  def clicar_botao_save_changes
    button_save_changes.click
  end
end
