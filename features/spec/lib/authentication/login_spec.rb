# frozen_string_literal: true

require_relative '../../spec_helper'
require_relative '../../../pages/authentication/login_page'

describe LoginPage do
  let(:login) { LoginPage.new }
  let!(:load_page) { login.load }

  shared_examples 'continuo na tela de login' do
    it 'continuo na tela de login' do
      expect(page).to have_css('#session_email')
      expect(page).to have_css('#session_password')
      expect(page).to have_xpath('//input[@value="Log in"]')
      expect(page).to have_xpath('//a[@href="/signup"]')
      expect(page).to have_xpath('//a[@href="/password_resets/new"]')
      expect(page).to have_css('#session_remember_me')
    end
  end

  context 'quando eu confirmar o login' do
    context 'caso eu nao preencha nenhum campo' do
      subject!(:dados_login) {
        login.preencher_dados_login('', '')
        login.clicar_botao_login
      }
      it_behaves_like 'continuo na tela de login'
    end

    context 'caso eu ponha email nao valido' do
      subject!(:lista_emails_invalidos) { ['@test.com', 'test@', 'test.com'] }
      it 'sera pedido que eu insira email valido' do
        lista_emails_invalidos.each do |email|
          login.preencher_dados_login(email, '123')
          login.clicar_botao_login
          message = login.find('#session_email').native.attribute('validationMessage')
          expect(message).to be == 'Digite um endereço de e-mail.'
        end
      end
    end

    context 'caso eu ponha email nao cadastado' do
      subject!(:dados_login) {
        login.preencher_dados_login('erro@erro.com', 'erro123')
        login.clicar_botao_login 
      }
      it_behaves_like 'continuo na tela de login'
    end

  context 'caso eu tenha esquecido a senha' do
    subject!(:dados_login) {
      login.clicar_link_forgot_password
    }
    it 'eu verei a pagina de reset de senha' do
      expect(page).to have_css('#password_reset_email')
      expect(page).to have_xpath('//input[@value="Submit"]')
    end
  end

  context 'caso eu nao tenha usuario' do
    subject!(:dados_login) {
      login.clicar_link_signup
    }
    it 'eu verei a pagina de cadastro de usuario' do
      expect(page).to have_css('#user_name')
      expect(page).to have_css('#user_email')
      expect(page).to have_css('#user_password')
      expect(page).to have_css('#user_password_confirmation')
      expect(page).to have_css('#new_user > input.btn.btn-primary.mt10')
    end
  end
end