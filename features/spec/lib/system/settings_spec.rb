# frozen_string_literal: true

require_relative '../../spec_helper'
require_relative '../../../pages/system/feed_page'
require_relative '../../../pages/authentication/login_page'
require_relative '../../../pages/system/settings_page'

let(:login) { LoginPage.new }
let(:settings) { SettingsPage.new }

describe SettingsPage do
  before do
    login.load
    login.preencher_dados_login('test@test.com', 'test123')
    login.clicar_botao_login

    settings.load
  end

  context 'quando altera com campos em branco' do
    it 'deve ver aviso de campos obrigatorios' do
      settings.preencher_dados_usuario(
        input_name: '',
        input_email: '',
        input_password: '',
        input_password_confirmation: ''
      )
      settings.clicar_botao_save_changes
      expect(page).to have_text('The form contains 3 error.')
      expect(page).to have_text('Name não pode ficar em branco')
      expect(page).to have_text('Email não pode ficar em branco')
      expect(page).to have_text('Email não é válido')
    end
  end

  context 'quando altera com email invalido' do
    it 'deve ver aviso de email invalido' do
      emails_invalidos = ['@test.com', 'test@', 'test.com']
      emails_invalidos.each do |email|
        settings.preencher_dados_usuario(
          input_name: 'Rails Test',
          input_email: email,
          input_password: 'teste123',
          input_password_confirmation: 'teste123'
        )
        settings.clicar_botao_save_changes
        message = page.find('#user_email').native.attribute('validationMessage')
        expect(message).to be == 'Digite um endereço de e-mail.'
      end
    end
  end

  context 'quando altera com senha invalida' do
    it 'deve ver aviso de senha invalida' do
      senhas_invalidas = ['12345', 'abcde', '@#$%ˆ', '1@Ev4']
      senhas_invalidas.each do |senha|
        settings.preencher_dados_usuario(
          input_name: 'Rails Test',
          input_email: 'test@test.com',
          input_password: senha,
          input_password_confirmation: senha
        )
        settings.clicar_botao_save_changes
        expect(page).to have_text('Password é muito curto (mínimo: 6 caracteres)')
      end
    end
  end

  context 'quando altera preechendo dados certos' do
    it 'os dados da conta devem ser alterados' do
      settings.preencher_dados_usuario(
        input_name: 'Rails Test',
        input_email: 'test@test.com',
        input_password: 'test123',
        input_password_confirmation: 'test123'
      )
      settings.clicar_botao_save_changes
      expect(page).to have_text('Rails Test')
      expect(page).to have_current_path('https://positiveness.herokuapp.com/users/106')
    end
  end
end
