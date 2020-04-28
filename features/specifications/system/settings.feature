#language: pt

Funcionalidade: Acessar as configuracoes de conta do usuario
    Para poder alterar nome, email ou a senha do meu usuario
    Sendo um usuario do sistema
    Posso entrar no nas configuracoes de minha conta

    Contexto:
        Dado que estou logado na minha conta
        E eu vou nas configuracoes do meu login

    Cenario: Tentar salvar com os campos em branco
        Quando  tento concluir com os campos em branco
        Entao eu verei um aviso de campos obrigatorios

    Esquema do Cenario: Tentar salvar dados com email invalido
        Quando informo um <email> invalido
        Entao eu verei uma mensagem de email invalido

        Exemplos:
            | email       |                    
            | "@test.com" |
            | "test@"     |
            | "test.com"  |

    Esquema do Cenario: Tentar salvar com senhas invalidas
        Quando informo uma <senha> invalida
        Entao eu verei uma mensagem de senha curta

        Exemplos:
            | senha |
            |'12345'|
            |'abcde'|
            |'@#$%ˆ'|
            |'1@Ev4'|

    Cenario: Tentar salvar usando dados corretos
        Quando confirmo a alteracao informando os seguintes dados:
            | name     | Rails Test    |
            | email    | test@test.com |
            | password | test123       |
        Entao verei a tela de profile