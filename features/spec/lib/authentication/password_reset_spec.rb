# frozen_string_literal: true

require_relative '../../spec_helper'
require_relative '../../../pages/authentication/password_reset_page'

describe PasswordResetPage do
  let(:password_reset) { PasswordResetPage.new }
  let!(:load_page) { password_reset.load }

  shared_examples 'continuando na tela de reset' do
    it 'deve continuar na tela de reset' do
      expect(page).to have_css('#password_reset_email')
      expect(page).to have_xpath('//input[@value="Submit"]')
    end
  end

  context 'quando confirmo sem preencher email' do
    it 'devo continuar na pagina' do
      password_reset.clicar_botao_submit
      password_reset.current_url.include? '/password_resets/'
      it_behaves_like 'continuando na tela de reset'
    end
  end

  context 'quando confirmo preenchendo email invalido' do
    it 'devo continuar na pagina' do
      password_reset.preencher_email('emailinexisteste@email.com')
      password_reset.clicar_botao_submit
      password_reset.current_url.include? '/password_resets/'
      it_behaves_like 'continuando na tela de reset'
    end
  end

  context 'preenchendo com um email invalido' do
    it 'o campo informara que o email e invalido' do
      emails_invalidos = ['@test.com', 'test@', 'test.com']
      emails_invalidos.each do |email|
        password_reset.preencher_email(email)
        password_reset.clicar_botao_submit
        message = password_reset.find('#password_reset_email').native.attribute('validationMessage')
        expect(message).to be == 'Digite um endereço de e-mail.'
      end
    end
  end

  context 'preenchendo com email cadastrado' do
    it 'devo receber mensagem de envio de link' do
      password_reset.preencher_email('vitorsouza@email.com')
      password_reset.clicar_botao_submit
      expect(page).to have_text('Verify your email')
    end
  end
end