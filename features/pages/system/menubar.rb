
  class MenuBar < SitePrism::Page
    element :link_home, ''
    element :link_help, ''
    element :link_list_users, ''
    element :account_menu, '.dropdown-toggle'
    element :link_profile, ''
    element :link_settings, ''
    element :link_log_out, :xpath, '//a[text()="Log out"]'

    def clicar_exibir_opcoes_perfil
      account_menu.click
    end

    def clicar_botao_logoff
      link_log_out.click
    end
  end
