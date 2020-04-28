# frozen_string_literal: true

require_relative '../../spec_helper'
require_relative '../../../pages/authentication/home_page'

describe HomePage do
  let!(:home) { HomePage.new }

  context 'Quando eu for criar conta nova' do
    it 'Entao devo ver a pagina de signup' do
      subject!(:home_page) {
        home.load
        home.clicar_botao_signup
      }
      expect(page).to have_css('#user_name')
      expect(page).to have_css('#user_email')
      expect(page).to have_css('#user_password')
      expect(page).to have_css('#user_password_confirmation')
      expect(page).to have_css('#new_user > input.btn.btn-primary.mt10')
    end
  end
end