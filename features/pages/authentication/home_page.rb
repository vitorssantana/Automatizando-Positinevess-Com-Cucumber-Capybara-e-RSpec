class HomePage < SitePrism::Page
    
    set_url "https://positiveness.herokuapp.com/"

    element :botao_signup, :xpath, "//a[@href='/signup']"
    element :link_home, :xpath, "//a[@href='/']"
    element :link_help, :xpath, "//a[@href='/help']"
    element :link_login, :xpath, "//a[@href='/login']"

    def clicar_botao_signup
        botao_signup.click
    end

    def clicar_link_home
        link_home.click
    end

    def clicar_link_help
        link_help.click
    end

    def clicar_link_login
        link_login.click
    end

end