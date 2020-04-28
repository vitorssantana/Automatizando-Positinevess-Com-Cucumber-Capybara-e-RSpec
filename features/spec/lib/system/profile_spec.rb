# frozen_string_literal: true

require_relative '../../spec_helper'
require_relative '../../../pages/system/feed_page'
require_relative '../../../pages/authentication/login_page'
require_relative '../../../pages/system/profile_page'

describe ProfilePage do
  let(:login) { LoginPage.new }
  let!(:profile) { ProfimePage.new }

  before do
    login.load
    login.preencher_dados_login('test@test.com', 'test123')
    login.clicar_botao_login
    profile.load
  end

  context 'acesso lista de seguidores' do
    it 'vejo minha lista de seguidores' do
      profile.clicar_link_list_followers
      expect(page).to have_current_path('/users/106/followers')
      expect(page).to have_text('Followers')
      expect(page).to have_xpath('//a[@href="/users/113"]')
      expect(page.find(:xpath, '(//a[@href="/users/113"])[2]').text).to be == 'Teste Automacao Vitor'
      expect(page).to have_xpath('//a[@href="/users/112"]')
      expect(page.find(:xpath, '(//a[@href="/users/112"])[2]').text).to be == 'Teste Automacao Vitor'
    end
  end

  context 'acesso lista de seguindo' do
    it 'vejo minha lista de quem me segue' do
      profile.clicar_link_list_following
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

  context 'deleto um post meu' do
    it 'no vejo mais o post no profile' do
      feed.load
      feed.preencher_campo_compose_new_post('TestProfile')
      feed.clicar_botao_post
      profile.load
      profile.deletar_post('TestProfile')
      expect(page).not_to have_xpath('//span[text()="TestProfile"]')
    end
  end
end
