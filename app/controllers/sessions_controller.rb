class SessionsController < ApplicationController
  def new
  end

  def create 
    @user = User.find_by_email(params[:email])
    @client = Client.find_by_email(params[:email])
    if @user.present?
      if !@user.authenticate(params[:password]).present?
        flash.now.alert = "Invalid email or password"
        render "new"
      elsif @user.authenticate(params[:password]).is_admin ==1
        session[:user_id] = @user.id
        redirect_to admin_users_url, :notice => "Logged in!"
      else
        flash.now.alert = "You are not admin"
        render "new"
      end
    elsif @client.present?
      if !@client.authenticate(params[:password]).present?
        flash.now.alert = "Invalid email or password"
        render "new"
      else
        session[:user_id] = @client.id
        redirect_to client_index_url, :notice => "Logged in!"
      end
    else
      flash.now.alert = "Invalid email or password"
      render "new"
    end
  end

  def destroy
      session[:user_id] = nil
      redirect_to new_session_url, :notice => "Logged out!"
  end

end
