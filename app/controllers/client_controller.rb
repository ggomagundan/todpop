class ClientController < ApplicationController
  before_filter :require_client
  helper_method :current_user
  def index
  end

  private
  def require_client
    if !current_user.present?
      redirect_to new_session_path
    end
  end

  def current_user
    @current_user ||= session[:user_id] && Client.find_by_id(session[:user_id]) 
  end
end
