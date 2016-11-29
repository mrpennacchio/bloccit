class FavoritesController < ApplicationController

  #redirect guests to sign in before allowing them to favorite a post
  before_action :require_sign_in

  def create
    # find the post we want to favorite using the post_id and params
    post = Post.find(params[:post_id])
    favorite = current_user.favorites.build(post: post)

    if favorite.save
      flash[:notice] = "Post favorited."
    else
      flash[:notice] = "Favoriting failed."
    end

    # redirect to user and posts show view

    redirect_to [post.topic, post]
  end

  def destroy
    post = Post.find(params[:post_id])
    favorite = current_user.favorites.find(params[:id])

    if favorite.destroy
      flash[:notice] = "Post unfavorited."
    else
      flash[:alert] = "Unfavoriting failed."
    end
    redirect_to [post.topic, post]
  end
end
