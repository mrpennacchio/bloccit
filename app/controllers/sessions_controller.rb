class SessionsController < ApplicationController

  def new
  end

  def create
    # search the database for a user with the specified email address in the params hash
    # use downcase to normalize email addresss since the addresses stored in the databse are stored as lowercase strings
    user = User.find_by(email: params[:session][:email].downcase)
    # verify that user is not nil and that the password in the params hash matches the password
    # will exit early if nil, checks that first
    if user && user.authenticate(params[:session][:password])
      create_session(user)
      flash[:notice] = "Welcome, #{user.name}!"
      redirect_to root_path
    else
      flash.now[:alert] = 'Invalid email/password combination'
      render :new
    end
  end

  # will delete session
  def destroy
    destroy_session(current_user)
    flash[:notice] = "You've been signed out, come back soon!"
    redirect_to root_path
  end

end
