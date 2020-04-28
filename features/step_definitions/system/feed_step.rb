  Before do
    @login = LoginPage.new
    @login.load
    @login.preencher_dados_login('test@test.com', 'test123')
    @login.clicar_botao_login
  end

  Dado("que estou logado na minha conta") do
    @feed = FeedPage.new
    @feed.load
  end

  Quando("eu quiser verificar quais sao os meus seguidores") do
    @feed.clicar_link_list_following
  end

  Entao("eu devo ver os usuarios que me seguem") do
    expect(page).to have_current_path('/users/106/following')
    expect(page).to have_text('Following')
    expect(page).to have_xpath('//a[@href="/users/6"]')
    expect(page.find(:xpath, '(//a[@href="/users/6"])[2]').text).to be == 'Example User'
    expect(page).to have_xpath('//a[@href="/users/9"]')
    expect(page.find(:xpath, '(//a[@href="/users/9"])[2]').text).to be == 'Dra. Morgana Moraes'
    expect(page).to have_xpath('//a[@href="/users/90"]')
    expect(page.find(:xpath, '(//a[@href="/users/90"])[2]').text).to be == 'Víctor Moraes'
  end

  Quando("eu quiser verificar quem eu sigo") do
    @feed.clicar_link_list_followers
  end

  Entao("eu devo ver os usuarios que eu sigo") do
    expect(page).to have_current_path('/users/106/followers')
    expect(page).to have_text('Followers')
    expect(page).to have_xpath('//a[@href="/users/113"]')
    expect(page.find(:xpath, '(//a[@href="/users/113"])[2]').text).to be == 'Teste Automacao Vitor'
    expect(page).to have_xpath('//a[@href="/users/112"]')
    expect(page.find(:xpath, '(//a[@href="/users/112"])[2]').text).to be == 'Teste Automacao Vitor'
  end

  Quando("eu postar uma nova informacao") do
    @feed.preencher_campo_compose_new_post('Estou postando no positiveness')
    @feed.clicar_botao_post
  end

  Entao("o post deve aparecer na minha pagina") do
    expect(page).to have_xpath('//span[text()="Estou postando no positiveness"]')
  end

  Quando("eu deletar alguma postagem minha") do
    @feed.deletar_post('Estou postando no positiveness')
  end

  Entao("essa postagem deve sair da minha pagina") do
    expect(page).not_to have_xpath('//span[text()="Estou postando no positiveness"]')
  end

  Quando("eu entro na pagina do usuario {string}") do |string|
    @feed.entrar_perfil_usuario(string)
  end

  Entao("devo ver a pagina daquele usuario") do
    expect(page).to have_current_path('/users/6')
    list = page.all(:xpath, '//li[@class="post-div"]').size
    expect(list).to be == 5
  end

  Quando("eu quiser verificar os seus seguidores") do
    @feed.clicar_link_list_followers
  end
  
  Entao("eu devo ver os usuarios que seguem ele") do
    expect(page).to have_xpath('//a[@href="/users/1"]')
    expect(page).to have_xpath('//a[@href="/users/108"]')
    expect(page).to have_xpath('//a[@href="/users/106"]')
    expect(page).to have_xpath('//a[text()="João Pedro"]')
    expect(page).to have_xpath('//a[text()="Lorena"]')
    expect(page).to have_xpath('//a[text()="Rails Test"]')
  end
  
  Quando("eu quiser verificar quem ele segue") do
    @feed.clicar_link_list_following
  end
  
  Entao("eu devo ver os usuarios que ele segue") do
    expect(page).to have_xpath('//a[@href="/users/1"]')
    expect(page).to have_xpath('//a[text()="João Pedro"]')
  end

  Quando("eu nao quiser mais seguir ele") do
    @feed.clicar_botao_unfollow
  end

  Entao("ele deve nao aparece mais na minha lista de seguidos") do
    @feed.load
    @feed.clicar_link_list_following
    expect(page).not_to have_xpath('//a[@href="/users/6"]')
    expect(page).not_to have_xpath('//a[text()="Example User"]')
  end

  E("eu nao devo aparecer na lista de seguidores de {string}") do |string|
    visit 'https://positiveness.herokuapp.com/users/6'
    @feed.clicar_link_list_followers
    expect(page).not_to have_xpath('//a[@href="/users/106"]')
    expect(page).not_to have_xpath('//a[text()="Rails Test"]')
  end

  E("eu acesso do usuario {string} pela lista de usuarios") do |string|
    @list_user = ListUsersPage.new
    @list_user.load
    @list_user.clicar_exibir_perfil_usuario(string)
  end

  Quando("eu quiser seguir ele") do
    @feed.clicar_botao_follow
  end

  Entao("ele deve aparecer na minha lista de seguidos") do
    @feed.load
    @feed.clicar_link_list_following
    expect(page).to have_xpath('//a[@href="/users/6"]')
    expect(page).to have_xpath('//a[text()="Example User"]')
  end

  E("eu devo aparecer na lista de seguidores de {string}") do |string|
    visit 'https://positiveness.herokuapp.com/users/6'
    @feed.clicar_link_list_followers
    expect(page).to have_xpath('//a[@href="/users/106"]')
    expect(page).to have_xpath('//a[text()="Rails Test"]')
  end

  Quando("eu desejar deslogar") do
    @menubar = MenuBar.new
    @menubar.clicar_exibir_opcoes_perfil
    @menubar.clicar_botao_logoff
  end

  Entao("eu devo ver a tela de signup") do
    expect(page).to have_text('Welcome to the POSITIVENESS, a place to share only good news! :)')
    expect(page).to have_xpath('//img[@alt="Positiveness"]')
    expect(page).to have_current_path('https://positiveness.herokuapp.com/')
  end