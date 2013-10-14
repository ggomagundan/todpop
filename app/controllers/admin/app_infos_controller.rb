# -*- encoding : utf-8 -*-
class Admin::AppInfosController < ApplicationController
  def index
    @app_infos = AppInfo.all
  end

  def show
    @app_info = AppInfo.find(params[:id])
  end

  def new
    @app_info = AppInfo.new
  end

  def create
    @app_info = AppInfo.new(params[:app_info])
    if @app_info.save
      redirect_to [:admin, @app_info], :notice => "Successfully created app info."
    else
      render :action => 'new'
    end
  end

  def edit
    @app_info = AppInfo.find(params[:id])
  end

  def update
    @app_info = AppInfo.find(params[:id])
    if @app_info.update_attributes(app_info_params)
      render :action => 'edit'
      #redirect_to [:admin, @app_info], :notice  => "Successfully updated app info."
    else
      render :action => 'edit'
    end
  end

  def destroy
    @app_info = AppInfo.find(params[:id])
    @app_info.destroy
    redirect_to admin_app_infos_url, :notice => "Successfully destroyed app info."
  end



 
  def app_info_params
    params.require(:app_info).permit(:time, :one_star, :two_star, :max_money, :android_version, :ios_version,  :app_server, :popup_style, :popup_image, :popup_text, :day_limit)
  end

end
