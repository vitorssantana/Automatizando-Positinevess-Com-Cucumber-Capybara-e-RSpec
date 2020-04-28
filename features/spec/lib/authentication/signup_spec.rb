# frozen_string_literal: true

require_relative '../../spec_helper'
require_relative '../../../pages/authentication/signup_page'

describe SignupPage do
  let(:signup) { SignupPage.new }
  let!(:load_page) { signup.load }

  context 'quando os campos estiverem em branco' do
    it 'sera avisado que campos sao obrigatorios' do
      signup.clicar_create_account
      expect(page).to have_text 'Name não pode ficar em branco'
      expect(page).to have_text 'Email não pode ficar em branco'
      expect(page).to have_text 'Email não é válido'
      expect(page).to have_text 'Password não pode ficar em branco'
    end
  end

  context 'quando o email informado for invalido' do
    it 'sera avisado que o email é invalido' do
      emails_invalidos = ['@test.com', 'test@', 'test.com']
      emails_invalidos.each do |email|
        inserir_confirmar_dados_user(
          'Teste Signup',
          email,
          '123456',
          '123456'
        )
        message = signup.find('#user_email').native.attribute('validationMessage')
        expect(message).to be == 'Digite um endereço de e-mail.'
      end
    end
  end

  context 'quando a senha tiver menos de 6 caracteres' do
    it 'sera avisado que a senha é muito curta' do
      senhas_invalidas = ['12345', 'abcde', '@#$%ˆ', '1@Ev4']
      senhas_invalidas.each do |senha|
        inserir_confirmar_dados_user(
          'Teste Signup',
          'testesignup.com',
          senha,
          senha
        )
        expect(page).to have_text('Password é muito curto (mínimo: 6 caracteres)')
      end
    end
  end

  context 'quando a senha não é igual a confirmação' do
    it 'sera avisado que as senhas nao sao iguais' do
      inserir_confirmar_dados_user(
        'Teste Signup',
        'testesignup.com',
        '123456',
        '654321'
      )
      expect(page).to have_text('Password confirmation não está de acordo com a confirmação')
    end
  end

  context 'quando eu informo dados corretamente' do
    it 'sera exibida a pagina home' do
      random_string = random_string()
      email = 'teste@email.com'
      inserir_confirmar_dados_user('Teste Automacao', email.insert(5, random_string.to_s), '123456', '123456')

      expect(page).to have_text('Welcome to the POSITIVENESS, a place to share only good news! :)')
      expect(page).to have_xpath('//img[@alt="Positiveness"]')
      expect(page).to have_current_path('https://positiveness.herokuapp.com/')
    end
  end

  def random_string(length = 6)
    chars = 'abcdefghjkmnpqrstuvwxyzABCDEFGHJKLMNPQRSTUVWXYZ0123456789'
    string = ''
    length.times { string << chars[rand(chars.size)] }
    string
  end

  def inserir_confirmar_dados_user(name, email, pwd, pwd_confirmation)
    signup.preencher_dados_usuario(
      input_name: name,
      input_email: email,
      input_password: pwd,
      input_password_confirmation: pwd_confirmation
    )
    signup.clicar_create_account
  end
end
