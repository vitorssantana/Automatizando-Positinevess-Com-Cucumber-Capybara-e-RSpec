  Before do
    @password_reset = PasswordResetPage.new
  end

  Dado('que estou na tela de reset de senha') do
    @password_reset.load
  end

  Quando('eu tentar resetar sem preencher email') do
    @password_reset.clicar_botao_submit
  end

  Entao('a pagina de reset nao deve ter nenhuma acao') do
    page.current_url.include? '/password_resets/'
    expect(page).to have_css('#password_reset_email')
    expect(page).to have_xpath('//input[@value="Submit"]')
  end

  Quando('eu informar email nao cadastrado') do
    @password_reset.preencher_email('emailinexisteste@email.com')
  end

  Quando('eu informar alguns {string} nao validos') do |string|
    @password_reset.preencher_email(string)
  end

  Entao('devo der a mensagem de que o email de reset esta invalido') do
    message = page.find('#password_reset_email').native.attribute('validationMessage')
    expect(message).to be == 'Digite um endereço de e-mail.'
  end

  Quando('eu informar o email cadastrado e valido') do |table|
    @email = table.rows_hash
    @password_reset.preencher_email(@email[:email])
    @password_reset.clicar_botao_submit
  end

  Entao('devo ver confirmacao de envio de email para reset de senha') do
    expect(page).to have_text('Verify your email')
  end