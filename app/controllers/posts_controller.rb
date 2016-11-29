class PostsController < ApplicationController

  # use before_action filter to call the require_sign_in method before each controller action
  before_action :require_sign_in, except: :show

  # check role of signed in user, if current user isnt authorized, redirect to show view.
  # before_action :authorize_user, except: [:show, :new, :create]



  def show
    # => find the post that corresponds to the id in the params that was passed to show and assign it to @post
    #    only assigning it to a single post.
    @post = Post.find(params[:id])
  end


  def new
    @topic = Topic.find(params[:topic_id])
    # => create an instance variable @post, assign it to an empty post by Post.new
    @post = Post.new
    unless current_user.moderator? || current_user.admin? || current_user.member?
      flash[:alert] = "You are not authorized to do that."
      redirect_to topics_path
    end
  end


  def create
    @topic = Topic.find(params[:topic_id])
    @post = @topic.posts.build(post_params)

    # we assign @post.user in the same way we assignemd @post.topic, to properly scope the new post
    @post.user = current_user

    unless current_user.moderator? || current_user.admin? || current_user.member?
      flash[:alert] = "You are not authorized to do that."
      redirect_to topics_path
    end

    # => if we save Post to the database a display success message wil appear
    if @post.save
      # => assign value to flash[:notice]. this provides a way to pass temporary values between actions
      flash[:notice] = "Post was saved."
      redirect_to [@topic, @post]
    else
      # => if not saved, displace error message and render a new view again
      flash.now[:alert] = "There was an error saving the post. Please try again."
      render :new
    end
  end


  def edit
    @post = Post.find(params[:id])

    unless current_user.moderator? || current_user.admin? || current_user.member?
      flash[:alert] = "You are not authorized to do that."
      redirect_to topics_path
    end

  end


  def update
    @post = Post.find(params[:id])
    @post.assign_attributes(post_params)


    unless current_user.moderator? || current_user.admin? || current_user.member?
      flash[:alert] = "You are not authorized to do that."
      redirect_to topics_path
    end

    if @post.save
      flash[:notice] = "Post was updated."
      redirect_to [@post.topic, @post]
    else
      flash.now[:alert] = "There was an error saving the post. Please try again"
      render :edit
    end
  end


  def destroy
    @post = Post.find(params[:id])

    unless current_user.member? || current_user.admin?
       flash[:alert] = "You must be an admin to do that."
       redirect_to [post.topic, post]
     end

    # => call destroy on post. if that call is successful, set a flash message and redirect the user to the post index view. else, try again
    if @post.destroy
      flash[:notice] = "\"#{@post.title}\" was deleted successfully"
      redirect_to @post.topic
    else
      flash.now[:alert] = "There was an error deleting the post"
      render :show
    end
  end

  private

  def post_params
    params.require(:post).permit(:title, :body)
  end

  # def authorize_mod
  #   unless current_user.moderator? || current_user.admin? || current_user == post.user
  #     flash[:alert] = "You are not authorized to do that."
  #     redirect_to topics_path
  #   end
  # end

  # def authorize_user
  #   post = Post.find(params[:id])
  #
  #   # redirect user unless they own the post they're attempting to modify, or theyre an admin
  #   unless current_user == post.user || current_user.admin?
  #     flash[:alert] = "You must be an admin to do that."
  #     redirect_to [post.topic, post]
  #   end
  # end
end
