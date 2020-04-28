#language: pt

Funcionalidade: Pagina de reset de senha
    Para que eu possa cresetar e criar uma senha nova
    Sendo um usuario
    Posso acessar a pagina de reset de senha

    Contexto:
        Dado que estou na tela de reset de senha

    Cenario: Tentar resetar sem preencher email    
        Quando eu tentar resetar sem preencher email
        Entao a pagina de reset nao deve ter nenhuma acao

    Cenario: Inserir emails nao cadastrados
        Quando eu informar email nao cadastrado
        Entao a pagina de reset nao deve ter nenhuma acao

    Esquema do Cenario: Inserir emails nao validos
        Quando eu informar alguns <emails> nao validos
        Entao devo der a mensagem de que o email de reset esta invalido

        Exemplos:
            | emails       |                    
            | "@test.com" |
            | "test@"     |
            | "test.com"  |

    Cenario: Inserir email valido
        Quando eu informar o email cadastrado e valido
            | email | vitorsouza@email.com |
        Entao  devo ver confirmacao de envio de email para reset de senha