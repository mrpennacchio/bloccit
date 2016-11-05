class PostsController < ApplicationController
  def index
    # => declare an instance variable @posts and assign it a collection of Post object using the all method
    @posts = Post.all

  end

  def show
  end

  def new
  end

  def edit
  end
end
