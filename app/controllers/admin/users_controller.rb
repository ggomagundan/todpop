# -*- encoding : utf-8 -*-
class Admin::UsersController < Admin::ApplicationController
  def index
    @users = User.all
    @counting = User.count
  end

  def show
    @user = User.find(params[:id])
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to [:admin, @user], :notice => "Successfully created user."
    else
      render :action => 'new'
    end
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update_attributes(user_params)
      redirect_to admin_users_path, :notice  => "Successfully updated user."
    else
      render :action => 'edit'
    end
  end

  def destroy
    @user = User.find(params[:id])
    @user.destroy
    redirect_to admin_users_url, :notice => "Successfully destroyed user."
  end

  private 
  def user_params
    params.require(:user).permit(:email, :facebook, :password, :password_confirmation, :nickname, :recommend , :sex , :birth , :address , :mobile ,  :last_connection , :level_test, :interest, :is_admin )
  end
end
