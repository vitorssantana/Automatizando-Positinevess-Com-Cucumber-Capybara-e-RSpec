#language: pt

Funcionalidade: Posts do feed no positiviness   
    Para que eu possa interagir com os usuarios
    Sendo um usuario do sistema
    Posso ver os meus posts e os posts dos usuarios que eu sigo

    Contexto:
        Dado que estou logado na minha conta

    Cenario: Verificar os meus seguidores
        Quando eu quiser verificar quais sao os meus seguidores
        Entao eu devo ver os usuarios que me seguem

    Cenario: Verificar os usuarios que eu sigo
        Quando eu quiser verificar quem eu sigo
        Entao eu devo ver os usuarios que eu sigo

    Cenario: Fazer um novo post
        Quando eu postar uma nova informacao
        Entao o post deve aparecer na minha pagina

    Cenario: Deletar post feito pelo usuario
        Quando eu deletar alguma postagem minha
        Entao essa postagem deve sair da minha pagina

    Cenario: Entrar na pagina de outro usuario
        Quando eu entro na pagina do usuario 'Example User' 
        Entao devo ver a pagina daquele usuario
        
    Cenario: Verificar os seguidores de outro usuario
        E eu entro na pagina do usuario 'Example User'
        Quando eu quiser verificar os seus seguidores
        Entao eu devo ver os usuarios que seguem ele

    Cenario: Verificar os usuarios que outro usuario segue
        E eu entro na pagina do usuario 'Example User'
        Quando eu quiser verificar quem ele segue
        Entao eu devo ver os usuarios que ele segue

    Cenario: Deixar de seguir usuario
        E eu entro na pagina do usuario 'Example User' 
        Quando eu nao quiser mais seguir ele
        Entao ele deve nao aparece mais na minha lista de seguidos
        E eu nao devo aparecer na lista de seguidores de 'Example User'

    Cenario: Seguir usuario
        E eu acesso do usuario 'Example User' pela lista de usuarios
        Quando eu quiser seguir ele
        Entao ele deve aparecer na minha lista de seguidos
        E eu devo aparecer na lista de seguidores de 'Example User'

    Cenario: Realizar logoff
        Quando eu desejar deslogar
        Entao verei a tela de home do positiveness
