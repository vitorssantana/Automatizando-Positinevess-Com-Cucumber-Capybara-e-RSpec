# frozen_string_literal: true

class ProfilePage < SitePrism::Page
  set_url ''

  element :link_list_following, :xpath, '//div[@class="stats"]/a[1]'
  element :link_list_followers, :xpath, '//div[@class="stats"]/a[2]'
  elements :lista_posts, :xpath, '//li[@class="post-div"]'

  def clicar_link_list_followers
    link_list_followers.click
  end

  def clicar_link_list_following
    link_list_following.click
  end

  def deletar_post(texto)
    lista_posts.each do |post|
      if post.find('.content').text == texto
        post.find('.btn').click
        break
      end
    end
  end
end
