class ApplicationController < ActionController::Base
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern

  before_action :require_login

  helper_method :current_user, :logged_in?

  private

  def log_in(user)
    session[:user_id] = user.id
  end

  def log_out
    forget(current_user) if current_user
    session.delete(:user_id)
    @current_user = nil
  end

  def remember(user)
    user.remember!
    cookies.permanent.signed[:user_id] = user.id
    cookies.permanent[:remember_token] = user.remember_token
  end

  def forget(user)
    user.forget!
    cookies.delete(:user_id)
    cookies.delete(:remember_token)
  end

  def current_user
    return @current_user if defined?(@current_user)

    @current_user =
      if session[:user_id]
        User.find_by(id: session[:user_id])
      elsif cookies.signed[:user_id] && cookies[:remember_token]
        user = User.find_by(id: cookies.signed[:user_id])
        if user&.authenticated?(cookies[:remember_token])
          log_in(user)
          user
        end
      end
  end

  def logged_in?
    current_user.present?
  end

  def require_login
    unless logged_in?
      redirect_to login_path, alert: "Faça login para continuar."
    end
  end
end
