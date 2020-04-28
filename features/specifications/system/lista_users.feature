#language: pt

Funcionalidade: Lista de Usuarios cadastrados no positiveness
    Para poder ver todos os usuarios cadastrados no positiveness
    Sendo um usuario do sistema
    Posso entrar na lista de usuarios cadastrados
    
    Contexto:
        Dado que estou logado na minha conta
        E acesso a lista de usuarios
    
    Cenario: Entrar no perfil de algum usuario
        Quando eu quiser entrar no perfil de 'Example User'
        Entao devo ver o feed desse usuario    