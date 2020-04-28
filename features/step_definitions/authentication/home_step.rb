  Dado("que estou na Homepage da positiviness") do
    @home = HomePage.new
    @home.load
  end
  
  Quando("eu quiser criar uma nova conta") do
    @home.clicar_botao_signup
  end
  
  Entao("deve ser solicitado as informacoes para o login") do
    expect(@home).to have_css('#user_name')
    expect(@home).to have_css('#user_email')
    expect(@home).to have_css('#user_password')
    expect(@home).to have_css('#user_password_confirmation')
    expect(@home).to have_css('#new_user > input.btn.btn-primary.mt10')
  end