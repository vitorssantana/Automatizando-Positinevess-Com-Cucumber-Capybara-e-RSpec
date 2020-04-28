#language: pt

Funcionalidade: Realizar login na pagina do positiviness
     Para que eu possa utilizar o positiviness
     Sendo um usuario do sistema
     Quero ser autenticado com minha conta no site da positiviness

    Contexto:
        Dado que eu estou na tela de login
    
    Cenario: Entrar na tela de reset de senha
        Quando eu perdi a senha e quero fazer reset
        Entao a pagina deve solicitar o preenchimendo do meu email
    
    Cenario: Entrar na tela de criacao de usuario
        Quando eu quiser criar uma conta nova
        Entao deve ser solicitado informacoes para meu cadastro

    Cenario: Tentar logar sem preencher os dados
        Quando eu confirmar o login sem preencher dados
        Entao a pagina de login nao deve ter nenhuma acao

    Cenario: Tentar logar utilizando emails nao cadastrado
        Quando eu confirmar informando email nao cadastrado
        Entao a pagina de login nao deve ter nenhuma acao

    Esquema do Cenario: Tentar logar utilizando emails invalidos
        Quando eu tentar logar com <email> invalido
        Entao  devo der a mensagem de que o email esta invalido

        Exemplos:
            | email       |                    
            | "@test.com" |
            | "test@"     |
            | "test.com"  |
    
    Cenario: Fazer login normalmente 
        Quando eu logar com dados corretos:
            | email| test@test.com|
            | senha| test123      |
        Entao eu devo ver o feed de posts da minha conta
