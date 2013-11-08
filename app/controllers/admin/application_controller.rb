# -*- encoding : utf-8 -*-
class Admin::ApplicationController < ActionController::Base
before_filter :require_admin
protect_from_forgery

layout 'admin'
 helper_method :current_user
private
  def require_admin
    if !current_user.present?
      redirect_to new_session_path
    elsif current_user.is_admin == 0
      redirect_to new_session_path
    else
    end
  end
 def current_user
       @current_user ||= session[:user_id] && User.find_by_id(session[:user_id]) 
 end  

end
