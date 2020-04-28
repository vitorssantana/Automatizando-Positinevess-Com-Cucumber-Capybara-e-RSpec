class SignupPage < SitePrism::Page
    set_url "https://positiveness.herokuapp.com/signup"

    element :input_name, '#user_name'
    element :input_email, '#user_email'
    element :input_password, '#user_password'
    element :input_password_confirmation, '#user_password_confirmation'
    element :botao_create_account, :xpath, '//input[@value="Create my account"]'

    def preencher_dados_usuario(**attrs)
        input_name.set attrs[:input_name]
        input_email.set attrs[:input_email]
        input_password.set attrs[:input_password]
        input_password_confirmation.set attrs[:input_password_confirmation]
    end

    def clicar_create_account
        botao_create_account.click
    end

end