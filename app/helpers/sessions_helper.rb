module SessionsHelper

  def log_in(user)
    session[:user_id] = user.id
  end


  def current_user
    if (user_id = session[:user_id])
      @current_user ||= User.find_by(id: user_id)
    elsif cookies[:remember_token]
      @current_user ||= User.find_by(remember_digest: cookies[:remember_token])
    end
  end

  def permanent_user
    User.find_by(id: cookies.signed[:user_id])
  end

  def logged_in?
    !@current_user.nil?
  end

  def remember(user)
    #user.create_remember_token
    user.remember
    cookies.permanent.signed[:user_id] = user.id
    cookies.permanent[:remember_token] = user.remember_token
  end

  def forget(user)
    user.forget
    cookies.delete(:remember_token)
  end

  def log_out
    forget(current_user)
    @current_user = nil
  end
end
