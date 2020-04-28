# frozen_string_literal: true

require_relative '../../spec_helper'
require_relative '../../../pages/system/feed_page'
require_relative '../../../pages/authentication/login_page'
require_relative '../../../pages/system/menubar'
require_relative '../../../pages/system/list_users_page'

describe FeedPage do
  let(:login) { LoginPage.new }
  let(:feed) { FeedPage.new }
  let(:list_user) { ListUsersPage.new }
  let(:menubar) { MenuBar.new }

  before do
    login.load
    login.preencher_dados_login('test@test.com', 'test123')
    login.clicar_botao_login
    feed.load
  end

  context 'clico no link de seguidores' do
    it 'eu verei os perfis que me seguem' do
      feed.clicar_link_list_following
      expect(page).to have_current_path('/users/106/following')
      expect(page).to have_text('Following')
      expect(page).to have_xpath('//a[@href="/users/6"]')
      expect(page.find(:xpath, '(//a[@href="/users/6"])[2]').text).to be == 'Example User'
      expect(page).to have_xpath('//a[@href="/users/9"]')
      expect(page.find(:xpath, '(//a[@href="/users/9"])[2]').text).to be == 'Dra. Morgana Moraes'
      expect(page).to have_xpath('//a[@href="/users/90"]')
      expect(page.find(:xpath, '(//a[@href="/users/90"])[2]').text).to be == 'Víctor Moraes'
    end
  end

  context 'clico no link de seguindo' do
    it 'eu verei os perfis que eu sigo' do
      feed.clicar_link_list_followers
      expect(page).to have_current_path('/users/106/followers')
      expect(page).to have_text('Followers')
      expect(page).to have_xpath('//a[@href="/users/113"]')
      expect(page.find(:xpath, '(//a[@href="/users/113"])[2]').text).to be == 'Teste Automacao Vitor'
      expect(page).to have_xpath('//a[@href="/users/112"]')
      expect(page.find(:xpath, '(//a[@href="/users/112"])[2]').text).to be == 'Teste Automacao Vitor'
    end
  end

  context 'preencho e posto um comentario' do
    it 'o post aparece no meu feed' do
      feed.preencher_campo_compose_new_post('Estou postando no positiveness')
      feed.clicar_botao_post
      expect(page).to have_xpath('//span[text()="Estou postando no positiveness"]')
    end
  end

  context 'deleto um post meu' do
    it 'o post sai do meu feed' do
      feed.deletar_post('Estou postando no positiveness')
      expect(page).not_to have_xpath('//span[text()="Estou postando no positiveness"]')
    end
  end

  context 'entro na pagina de um usuario' do
    it 'evo ver a pagina daquele usuario' do
      feed.entrar_perfil_usuario('Example User')
      expect(page).to have_current_path('/users/6')
      list = page.all(:xpath, '//li[@class="post-div"]').size
      expect(list).to be == 5
    end
    context 'clico no link de seguidores' do
      it 'vejo os perfis que seguem ele' do
        feed.entrar_perfil_usuario('Example User')
        feed.clicar_link_list_followers
        expect(page).to have_xpath('//a[@href="/users/1"]')
        expect(page).to have_xpath('//a[@href="/users/108"]')
        expect(page).to have_xpath('//a[@href="/users/106"]')
        expect(page).to have_xpath('//a[text()="João Pedro"]')
        expect(page).to have_xpath('//a[text()="Lorena"]')
        expect(page).to have_xpath('//a[text()="Rails Test"]')
      end
    end

    context 'clico no link de seguindo' do
      it 'vejo os perfis que ele segue' do
        feed.entrar_perfil_usuario('Example User')
        feed.clicar_link_list_following
        expect(page).to have_xpath('//a[@href="/users/1"]')
        expect(page).to have_xpath('//a[text()="João Pedro"]')
      end
    end

    context 'o deixo de seguir' do
      it 'ele sai da lista de meus seguidores' do
        feed.entrar_perfil_usuario('Example User')
        feed.clicar_botao_unfollow
        feed.load
        feed.clicar_link_list_following
        expect(page).not_to have_xpath('//a[@href="/users/6"]')
        expect(page).not_to have_xpath('//a[text()="Example User"]')
        visit 'https://positiveness.herokuapp.com/users/6'
        feed.clicar_link_list_followers
        expect(page).not_to have_xpath('//a[@href="/users/106"]')
        expect(page).not_to have_xpath('//a[text()="Rails Test"]')
      end
    end

    context 'eu sigo ele novamente' do
      it 'ele entra na minha lista de seguidores' do
        list_user.load
        list_user.clicar_exibir_perfil_usuario('Example User')
        feed.clicar_botao_follow
        feed.load
        feed.clicar_link_list_following
        expect(page).to have_xpath('//a[@href="/users/6"]')
        expect(page).to have_xpath('//a[text()="Example User"]')
        visit 'https://positiveness.herokuapp.com/users/6'
        feed.clicar_link_list_followers
        expect(page).to have_xpath('//a[@href="/users/106"]')
        expect(page).to have_xpath('//a[text()="Rails Test"]')
      end
    end
  end

  context 'eu faco logoff do positiveness' do
    it 'eu vejo a home do positiveness' do
      menubar.clicar_exibir_opcoes_perfil
      menubar.clicar_botao_logoff
      expect(page).to have_text('Welcome to the POSITIVENESS, a place to share only good news! :)')
      expect(page).to have_xpath('//img[@alt="Positiveness"]')
      expect(page).to have_current_path('https://positiveness.herokuapp.com/')
    end
  end
end
