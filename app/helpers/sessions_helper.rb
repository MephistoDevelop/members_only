# frozen_string_literal: true

module SessionsHelper
  def log_in(user)
    session[:user_id] = user.id
  end

  def current_user
    user ||= User.find_by(id: cookies.signed[:user_id])

    log_in(user) if user&.decrypt(cookies.signed[:remember])
    @current_user = user
    # if (user_id = session[:user_id])
    # @current_user ||= User.find_by(id: user_id)
    # elsif cookies[:remember_token]
    # #TSE changes @current_user=User.find_by(id: cookies.signed[:user_id])
    # end
  end

  def permanent_user
    @current_user = User.find_by(id: cookies.signed[:user_id])
  end

  def logged_in?
    !current_user.nil?
  end

  def remember(user)
    # user.create_remember_token
    user.remember
    cookies.permanent.signed[:user_id] = user.id
    cookies.permanent.signed[:remember_token] = user.remember_token
  end

  def forget(user)
    user.forget
    cookies.delete(:remember_token)
    cookies.delete(:user_id)
  end

  def log_out
    forget(current_user)
    @current_user = nil
  end
end
