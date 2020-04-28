#language: pt

Funcionalidade: Acessar a pagina do usuario
    Para que eu possa ver somente os meus posts e deleta-los
    Sendo um usuario do sistema
    Posso entrar no meu profile

    Contexto: Postar no meu feed
        Dado que estou logado na minha conta

    Cenario: Entrar na lista de seguindo
        Quando eu entrar na minha lista de seguindo
        Entao eu devo ver os usuarios que me seguem
        
    Cenario: Entrar na lista de seguidores
        Quando eu entrar na minha lista de seguidores
        Entao eu devo ver os usuarios que eu sigo

    Cenario: Deletar um post
        E eu posto no meu feed um comentario
        Quando eu deletar o post no profile
        Entao nao devo mais ver essa post no meu profile