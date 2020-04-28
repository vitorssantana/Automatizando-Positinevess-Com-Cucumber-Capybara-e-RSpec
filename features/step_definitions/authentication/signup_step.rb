  Before do
    @signup = SignupPage.new
  end
  
  Dado("que estou na tela de signup") do
    @signup.load
  end
  
  Quando("eu tento cadastrar com todos os campos em branco") do
    @signup.clicar_create_account
  end
  
  Entao("eu verei um aviso de que campos sao obrigatorios") do
    expect(page).to have_text ('Name não pode ficar em branco')
    expect(page).to have_text ('Email não pode ficar em branco')
    expect(page).to have_text ('Email não é válido')
    expect(page).to have_text ('Password não pode ficar em branco')
  end
  
  Quando("eu informo um {string} invalido") do |string|
    @signup.preencher_dados_usuario(
        input_name: 'Teste Signup',
        input_email: string,
        input_password: '123456',
        input_password_confirmation: '123456'
    )
    @signup.clicar_create_account
  end
  
  Entao("eu verei uma mensagem de que email e invalido") do
    message = page.find("#user_email").native.attribute("validationMessage")
    expect(message).to be == ('Digite um endereço de e-mail.')
  end
  
  Quando("eu informo uma {string} invalida") do |string|
    @signup.preencher_dados_usuario(
        input_name: 'Teste Signup',
        input_email: 'teste@signup.com',
        input_password: string,
        input_password_confirmation: string
    )
    @signup.clicar_create_account
  end
  
  Entao("eu verei uma mensagem de que a senha e muito curta") do
    expect(page).to have_text('Password é muito curto (mínimo: 6 caracteres)')
  end
  
  Quando("eu informo uma senha valida") do
    @signup.preencher_dados_usuario(
        input_name: 'Teste Signup',
        input_email: 'teste@signup.com',
        input_password: '123456'
    )
  end
  
  E("no campo de confirmacao eu coloco outra senha valida") do
    @signup.preencher_dados_usuario(
        input_name: 'Teste Signup',
        input_email: 'teste@signup.com',
        input_password: '123456',
        input_password_confirmation: '654321'
    )
    @signup.clicar_create_account
  end
  
  Entao("eu serei avisado que a senha não está de acordo com a confirmação") do
    expect(page).to have_text('Password confirmation não está de acordo com a confirmação')
  end
  
  Quando("eu confirmo o cadastro informando os seguintes dados:") do |table|
    @usuario = table.rows_hash
    random_string = random_string()
    @signup.preencher_dados_usuario(
        input_name: @usuario[:name],
        input_email: @usuario[:email].insert(5, "#{random_string}"),
        input_password: @usuario[:password],
        input_password_confirmation: @usuario[:password]
    )
    
    @signup.clicar_create_account
  end
  
  Entao("verei a tela de home do positiveness") do
    expect(page).to have_text('Welcome to the POSITIVENESS, a place to share only good news! :)')
    expect(page).to have_xpath('//img[@alt="Positiveness"]')
    expect(page).to have_current_path('https://positiveness.herokuapp.com/')
  end

  def random_string(length=6)
    chars = 'abcdefghjkmnpqrstuvwxyzABCDEFGHJKLMNPQRSTUVWXYZ0123456789'
    string = ''
    length.times { string << chars[rand(chars.size)] }
    string
  end