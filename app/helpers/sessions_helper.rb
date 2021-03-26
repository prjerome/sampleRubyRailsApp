module SessionsHelper
  # Logs in the given user
  def log_in(user)
    session[:user_id] = user.id
  end

  # Returns the current logged in user
  def current_user
    if sessions[:user_id]
       @current_user ||= User.find_by(id: [session[:user_id]])
    end
  end

  # Check if user is logged in
  def logged_in?
    !current_user.nil?
  end
  
end
