# frozen_string_literal: true

require_relative '../../spec_helper'
require_relative '../../../pages/authentication/login_page'
require_relative '../../../pages/system/list_users_page'
require_relative '../../../pages/system/menubar'

describe ListUsersPage do
  let(:login) { LoginPage.new }
  let(:list_user) { ListUsersPage.new }

  before do
    login.load
    login.preencher_dados_login('test@test.com', 'test123')
    @login.clicar_botao_login
    list_user.load
  end

  context 'quando eu quiser ver os dados de um usuario' do
    it 'devo ver o feed daquele usuario' do
      @list_user.clicar_exibir_perfil_usuario('Example User')
      expect(@list_user).to have_current_path('/users/6')
      list = @list_user.all(:xpath, '//li[@class="post-div"]').size
      expect(list).to be == 5
    end
  end
end
