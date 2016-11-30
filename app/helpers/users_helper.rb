module UsersHelper

  def has_no_posts?
    @user.posts.count == 0
    "{user.name} has not submitted any posts yet."
  end

  def has_no_comments?
    @user.comments.count == 0
    "{user.name} has not submitted any posts yet."
  end

end
