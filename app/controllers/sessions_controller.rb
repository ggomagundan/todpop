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

  
  def client_sign_up
  end

  def sign_up
    if !params[:cor_name].present? || !params[:name].present? || !params[:email].present? || !params[:password].present? || !params[:mobile].present?
      flash.now.alert = "please input all data"
      render "new"
    elsif Client.find_by_email(params[:email]).present?
      flash.now.alert = "Exist email"
      render "new"
    elsif Client.find_by_mobile(params[:mobile]).present?
      flash.now.alert = "Exist mobile"
      render "new"
    elsif params[:password] != params[:password_confirmation]
      flash.now.alert = "These password don't match. Try again."
      render "new"
    else
      @client = Client.new
      @client.password = params[:password]
      @client.password_confirmation = params[:password]
      @client.cor_name = params[:cor_name]
      @client.name = params[:name]
      @client.email = params[:email]
      @client.mobile = params[:mobile]
      if !@client.save
        flash.now.alert = "Sign up failed. Try again."
        render "new"
      else
        @client=Client.find_by_email(params[:email])
        session[:user_id]=@client.id
        redirect_to client_index_url, :notice => "Sign up success."
      end
    end
  end
end
