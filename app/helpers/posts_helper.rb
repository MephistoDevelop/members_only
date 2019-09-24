# frozen_string_literal: true

module PostsHelper
  def user_in(post)
    logged_in? ? post.user.name : (link_to 'Login', login_path)
  end
end
