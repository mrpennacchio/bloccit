module SessionsHelper
  # sets user_id on the session object to user.id, unique for each user. session is an object that tracks state of user
  def create_session(user)
    session[:user_id] = user.id
  end

  # clear user id on session object by setting it to nil, destroys user session
  def destroy_session(user)
    session[:user_id] = nil
  end

  # returns current user of application. encapsulates pattern of finding the current user that we would otherwise call through bloccit
  # our shortcut for finding the current user.
  def current_user
    User.find_by(id: session[:user_id])
  end

end
