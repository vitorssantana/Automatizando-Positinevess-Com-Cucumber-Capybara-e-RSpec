#language: pt

Funcionalidade: Cadastrar um novo usuario no positiveness
    Para poder cadastrar um nome fornacendo nome, email e sua senha
    Sendo um usuario do sistema
    Posso entrar no na tela de signup do positinevess

    Contexto:
        Dado que estou na tela de signup

    Cenario: Tentar salvar com os campos em branco
        Quando eu tento cadastrar com todos os campos em branco
        Entao eu verei um aviso de que campos sao obrigatorios

    Esquema do Cenario: Tentar salvar dados com email invalido
        Quando eu informo um <email> invalido
        Entao eu verei uma mensagem de que email e invalido
      
        Exemplos:
            | email       |                    
            | "@test.com" |
            | "test@"     |
            | "test.com"  |

    Esquema do Cenario: Tentar salvar com senha com menos de 6 caracteres
        Quando eu informo uma <senha> invalida
        Entao eu verei uma mensagem de que a senha e muito curta
        
        Exemplos:
            | senha |
            |'12345'|
            |'abcde'|
            |'@#$%ˆ'|
            |'1@Ev4'|
    
    Cenario: tentar salvar com o campo da senha diferente da confirmacao de senha
        Quando eu informo uma senha valida
        E no campo de confirmacao eu coloco outra senha valida
        Entao eu serei avisado que a senha não está de acordo com a confirmação

    Cenario: Tentar salvar usando dados corretos
        Quando eu confirmo o cadastro informando os seguintes dados:
        | name     | Teste Automacao Vitor |
        | email    | vitorsouza@emails.com  |
        | password | 123@123               |
        Entao verei a tela de home do positiveness