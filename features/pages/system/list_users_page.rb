class ListUsersPage < SitePrism::Page
  set_url 'https://positiveness.herokuapp.com/users'
  elements :lista_users, :xpath, '//tr'

  def clicar_exibir_perfil_usuario(string)
    all(:xpath, '/html/body/div/table/tbody/tr/td[1]').each do |user|
      if user.text == string
        user.find(:xpath, '../td[3]/a').click
        break
      end
    end
  end
end