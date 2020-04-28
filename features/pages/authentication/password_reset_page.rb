class PasswordResetPage < SitePrism::Page
  set_url ''

  element :input_email, '#password_reset_email'
  element :botao_submit, :xpath, '//input[@value="Submit"]'

  def preencher_email(email)
    input_email.set email
  end

  def clicar_botao_submit
    botao_submit.click
  end
end