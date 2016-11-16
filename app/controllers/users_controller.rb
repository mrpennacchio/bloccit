class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
    # create new user with new and set corresponding attributes with params hash
    @user = User.new
    @user.name = params[:user][:name]
    @user.email = params[:user][:email]
    @user.password = params[:user][:password]
    @user.password_confirmation = params[:user][:password_confirmation]
    # we save the user to the database. If the database save is successful, add flash message, redirect to root path
    if @user.save
      flash[:notice] = "Welcome to Bloccit #{@user.name}!"
      redirect_to root_path
    else
      flash.now[:alert] = "There was an error creating your account. Please try again"
      render :new
    end
  end
end
