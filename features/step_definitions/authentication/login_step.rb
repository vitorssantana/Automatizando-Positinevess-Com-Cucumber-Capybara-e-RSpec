  Before do
    @login = LoginPage.new
  end

  Dado("que eu estou na tela de login") do
    @login = LoginPage.new
    @login.load
  end

  Quando("eu perdi a senha e quero fazer reset") do
    @login.clicar_link_forgot_password
  end

  Entao("a pagina deve solicitar o preenchimendo do meu email") do
    expect(page).to have_css('#password_reset_email')
    expect(page).to have_xpath('//input[@value="Submit"]')
  end

  Quando("eu quiser criar uma conta nova") do
    @login.clicar_link_signup
  end

  Entao("deve ser solicitado informacoes para meu cadastro") do
    expect(page).to have_css('#user_name')
    expect(page).to have_css('#user_email')
    expect(page).to have_css('#user_password')
    expect(page).to have_css('#user_password_confirmation')
    expect(page).to have_css('#new_user > input.btn.btn-primary.mt10')
  end

  Quando("eu confirmar o login sem preencher dados") do
    @login.preencher_dados_login('', '')
    @login.clicar_botao_login
  end

  Entao("a pagina de login nao deve ter nenhuma acao") do
    expect(page).to have_css('#session_email')
    expect(page).to have_css('#session_password')
    expect(page).to have_xpath('//input[@value="Log in"]')
    expect(page).to have_xpath('//a[@href="/signup"]')
    expect(page).to have_xpath('//a[@href="/password_resets/new"]')
    expect(page).to have_css('#session_remember_me'
    )
  end

  Quando("eu confirmar informando email nao cadastrado") do
    @login.preencher_dados_login('errado@errado.errado', 'errado'
    )
    @login.clicar_botao_login
  end

  Quando("eu tentar logar com {string} invalido") do |string|
    @login.preencher_dados_login(string, '')
    @login.clicar_botao_login
  end

  Entao("devo der a mensagem de que o email esta invalido") do
    message = page.find("#session_email").native.attribute("validationMessage")
    expect(message).to be == 'Digite um endereço de e-mail.'
  end

  Quando("eu logar com dados corretos:") do |table|
    @usuario = table.rows_hash
    @login.preencher_dados_login(@usuario[:email], @usuario[:senha])
    @login.clicar_botao_login
  end

  Entao("eu devo ver o feed de posts da minha conta") do
    expect(page).to have_current_path('/users/106')
    list = Array.new 
    list = page.all(:xpath, '//li[@class="post-div"]').size
    expect(list).to be == 5
    expect(page).to have_text 'Rails Test'

    expect(page).to have_xpath('//a[@href="/"]')
    expect(page).to have_xpath('//a[@href="/help"]')
    expect(page).to have_xpath('//a[@href="/users"]')
    expect(page).to have_xpath('//a[@href="#"]')
  end