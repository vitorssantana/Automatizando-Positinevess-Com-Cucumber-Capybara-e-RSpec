E("acesso a lista de usuarios") do
  @list_user = ListUsersPage.new
  @list_user.load
end
  
Quando("eu quiser entrar no perfil de {string}") do |string|
  @list_user.clicar_exibir_perfil_usuario(string)
end
  
Entao("devo ver o feed desse usuario") do
  expect(page).to have_current_path('/users/6')
  list = page.all(:xpath, '//li[@class="post-div"]').size
  expect(list).to be == 5
end