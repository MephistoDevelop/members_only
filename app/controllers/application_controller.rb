# frozen_string_literal: true

class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  include SessionsHelper

  def loged_in?
    current_user
  end

  def current_user
    return nil unless cookies.signed[:user_id]

    @current_user ||= User.find_by(id: cookies.signed[:user_id])
  end
end
