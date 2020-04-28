class LoginPage < SitePrism::Page
  set_url 'https://positiveness.herokuapp.com/login'
  element :input_email, '#session_email'
  element :input_password, '#session_password'
  element :botao_login, :xpath, '//input[@value="Log in"]'
  element :link_signup, :xpath, '//a[@href="/signup"]'
  element :link_forgot_password, :xpath, '//a[@href="/password_resets/new"]'
  element :check_remember_this_computer, '#session_remember_me'

  def preencher_dados_login(email, password)
    input_email.set email
    input_password.set password
  end

  def clicar_botao_login
    botao_login.click
  end

  def clicar_link_signup
    link_signup.click
  end

  def clicar_link_forgot_password
    link_forgot_password.click
  end

  def marcar_check_remember_this_computer
    check_remember_this_computer.click
  end
end