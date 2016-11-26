class CommentsController < ApplicationController
  # ensure that the guest users are not premitted to create comments
  before_action :require_sign_in

  # ensure unauthorized users are not permitted to delete comments
  before_action :authorize_user, only: [:destroy]

  def create
    # find the correct post using post_id and then create a new comment using comment_params
    # assign comment's user to current_user, and return the signed in user instance
    @post = Post.find(params[:post_id])
    comment = @post.comments.new(comment_params)
    comment.user = current_user

    if comment.save
      flash[:notice] = "Comment saved successfully."
      # if saved, redirect to post show view
      redirect_to [@post.topic, @post]
    else
      flash[:alert] = "Comment failed to save."
      # if not saved, redirect to post show view
      redirect_to [@post.topic, @post]
    end
  end


  def destroy
    @post = Post.find(params[:post_id])
    comment = @post.comments.find(params[:id])

    if comment.destroy
      flash[:notice] = "Comment was deleted."
      redirect_to [@post.topic, @post]
    else
      flash[:alert] = "Comment couldn't be deleted. Try again."
      redirect_to [@post.topic, @post]
    end
  end

  private

  # white lists paramaters we need to create comments
  def comment_params
    params.require(:comment).permit(:body)
  end

  # allows owner ot admin to delete a comment, if not, reidrect to the post show view
  def authorize_user
    comment = Comment.find(params[:id])
    unless current_user == comment.user || current_user.admin?
      flash[:alert] = "You do not have permission to delete a comment."
      redirect_to [comment.post.topic, comment.post]
    end
  end
end
