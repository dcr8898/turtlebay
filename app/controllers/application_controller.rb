class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  helper_method :current_user, :logged_in?, :error_builder

  def current_user
    @user ||= User.find_by(id: session[:user_id]) if session[:user_id]
  end

  def logged_in?
    current_user != nil
  end

  def error_builder(error_collection)
    flash.now[:error] = []
    error_collection.each do |error|
      flash.now[:error] << error
    end
  end

end
