class FavoriteMailer < ApplicationMailer
  default from: "mrpennacchio@gmail.com"

  def new_comment(user, post, comment)
    # set three different headers to enable conversation threading in different email clients
    headers["Message-ID"] = "<comments/#{comment.id}@your-app-name.example"
    headers["In-Reply_to"] = "<post/#{post.id}@your-app-name.example"
    headers["References"] = "<post/#{post.id}@your-app-name.example"

    @user = user
    @post = post
    @comment = comment

    # the mail method takes a hash of mail-relevant information - the subject
    # to address, the from and any cc or bcc information and prepares the email to be sent
    mail(to: user.email, subject: "New comment on #{post.title}")
  end

  def new_post(post)
    headers["Message-ID"] = "<post/#{post.id}@your-app-name.example"
    headers["In-Reply_to"] = "<post/#{post.id}@your-app-name.example"
    headers["References"] = "<post/#{post.id}@your-app-name.example"

    @post = post

    mail(to: post.user.email, subject: "You are now following: #{post.title}! ")
  end

end
