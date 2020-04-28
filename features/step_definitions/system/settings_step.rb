 Before do
   @settings = SettingsPage.new
 end
 
  E("eu vou nas configuracoes do meu login") do
    @settings.load
  end
  
  Quando("tento concluir com os campos em branco") do
    @settings.preencher_dados_usuario(
        input_name: '',
        input_email: '',
        input_password: '',
        input_password_confirmation: ''
    )
    @settings.clicar_botao_save_changes
  end
  
  Entao("eu verei um aviso de campos obrigatorios") do
    expect(page).to have_text('The form contains 3 error.')
    expect(page).to have_text('Name não pode ficar em branco')
    expect(page).to have_text('Email não pode ficar em branco')
    expect(page).to have_text('Email não é válido')
  end
  
  Quando("informo um {string} invalido") do |string|
    @settings.preencher_dados_usuario(
        input_name: 'Rails Test',
        input_email: string,
        input_password: 'teste123',
        input_password_confirmation: 'teste123'
    )
    @settings.clicar_botao_save_changes
  end
  
  Entao("eu verei uma mensagem de email invalido") do
    message = page.find("#user_email").native.attribute("validationMessage")
    expect(message).to be == ('Digite um endereço de e-mail.')
  end
  
  Quando("informo uma {string} invalida") do |string|
    @settings.preencher_dados_usuario(
        input_name: 'Rails Test',
        input_email: 'test@test.com',
        input_password: string,
        input_password_confirmation: string
    )
    @settings.clicar_botao_save_changes
  end
  
  Entao("eu verei uma mensagem de senha curta") do
    expect(page).to have_text('Password é muito curto (mínimo: 6 caracteres)')
  end
  
  Quando("confirmo a alteracao informando os seguintes dados:") do |table|
    @usuario = table.rows_hash
    @settings.preencher_dados_usuario(
        input_name: @usuario[:name],
        input_email: @usuario[:email],
        input_password: @usuario[:password],
        input_password_confirmation: @usuario[:password]
    )
    @settings.clicar_botao_save_changes
  end
  
  Entao("verei a tela de profile") do
    expect(page).to have_text('Rails Test')
    expect(page).to have_current_path('https://positiveness.herokuapp.com/users/106')
  end