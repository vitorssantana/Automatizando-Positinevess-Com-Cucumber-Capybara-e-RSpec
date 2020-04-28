
class FeedPage < SitePrism::Page
  set_url 'https://positiveness.herokuapp.com/'

  element :link_view_my_profile, :xpath, '//a[text()="view my profile "]'
  element :link_list_following, :xpath, '//div[@class="stats"]/a[1]'
  element :link_list_followers, :xpath, '//div[@class="stats"]/a[2]'
  element :campo_compose_new_post, '#post_content'
  element :botao_post, :xpath, '//input[@value="Post"]'
  elements :lista_posts, :xpath, '//li[@class="post-div"]'
  element :botao_follow, :xpath, '//input[@value="Follow"]'
  element :botao_unfollow, :xpath, '//input[@value="Unfollow"]'

  def clicar_link_view_my_profile
    link_view_my_profile.click
  end

  def clicar_link_list_following
    link_list_following.click
  end

  def clicar_link_list_followers
    link_list_followers.click
  end

  def preencher_campo_compose_new_post(texto)
    campo_compose_new_post.set texto
  end

  def clicar_botao_post
    botao_post.click
  end

  def deletar_post(texto)
    lista_posts.each do |post|
      if post.find('.content').text == texto
        post.find('.btn').click
        break
      end
    end
  end

  def entrar_perfil_usuario(usuario)
    lista_posts.each do |user|
      if user.find('.user > a').text == usuario
        user.find('.user > a').click
        break
      end
    end
  end

  def clicar_botao_follow
    botao_follow.click
  end

  def clicar_botao_unfollow
    botao_unfollow.click
  end
end