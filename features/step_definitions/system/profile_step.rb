
  Before do
    @profile = ProfilePage.new
    @profile.load
  end
  
  Quando("eu entrar na minha lista de seguindo") do
    @profile.clicar_link_list_following
  end
  
  Quando("eu entrar na minha lista de seguidores") do
    @profile.clicar_link_list_followers
  end
  
  E("eu posto no meu feed um comentario") do
    @feed = FeedPage.new
    @feed.preencher_campo_compose_new_post('TestProfile')
    @feed.clicar_botao_post
  end
  
  Quando("eu deletar o post no profile") do
    @profile.load
    @profile.deletar_post('TestProfile')
  end
  
  Entao("nao devo mais ver essa post no meu profile") do
    expect(page).not_to have_xpath('//span[text()="TestProfile"]')
  end