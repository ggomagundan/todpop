# -*- encoding : utf-8 -*-
class Admin::ApplicationController < ActionController::Base
#before_filter :require_admin
protect_from_forgery

layout 'admin'
private
  def require_admin
    if !current_user.present?
      redirect_to admin_sessions_path
    elsif current_user.is_admin == 0
      redirect_to admin_sessions_path
    end
  end
 def current_user
       @current_user ||= session[:current_user_id] && User.find_by_id(session[:current_user_id]) 
 end  
 helper_method :current_user

end
