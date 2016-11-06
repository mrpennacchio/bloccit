class PostsController < ApplicationController
  def index
    # => declare an instance variable @posts and assign it a collection of Post object using the all method
    @posts = Post.all

  end

  def show
    # => find the post that corresponds to the id in the params that was passed to show and assign it to @post
    #    only assigning it to a single post. 
    @post = Post.find(params[:id])
  end

  def new
    # => create an instance variable @post, assign it to an empty post by Post.new
    @post = Post.new
  end

  def create
    # => call Post.new to create new instance of Post
    @post = Post.new
    @post.title = params[:post][:title]
    @post.body = params[:post][:body]

    # => if we save Post to the database a display success message wil appear
    if @post.save
      # => assign value to flash[:notice]. this provides a way to pass temporary values between actions
      flash[:notice] = "Post was saved."
      redirect_to @post
    else
      # => if not saved, displace error message and render a new view again
      flash.now[:alert] = "There was an error saving the post. Please try again."
      render :new
  end
end

  def edit
  end
end
