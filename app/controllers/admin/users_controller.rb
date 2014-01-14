# -*- encoding : utf-8 -*-
class Admin::UsersController < Admin::ApplicationController
  skip_before_filter :verify_authenticity_token
  def index
    @counting = User.count
    @page = params[:page] ? params[:page] : 1
    if params[:search_user].present?
      q = "%#{params[:search_user]}%"
      @users = User.where("id LIKE ? OR email LIKE ? OR facebook LIKE ? OR mobile LIKE ? OR nickname LIKE ?", q, q, q, q, q).page(params[:page]).per(15)
    else
      @users = User.page(params[:page]).per(15)
    end
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
    #@user.password = Digest::SHA512.hexdigest(temp.to_s)
    #@user.password_confirmation = Digest::SHA512.hexdigest(temp.to_s)
    @user.password = params[:password]
    @user.password_confirmation = params[:password]
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
    params.require(:user).permit(:email, :facebook, :password, :password_confirmation, :nickname, :recommend , :sex , :birth , :address , :mobile , :last_connection , :level_test, :interest, :is_admin )
  end
end
