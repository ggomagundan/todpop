# -*- encoding : utf-8 -*-
class Api::AppInfosController < ApplicationController

  def get_fast_pivot_time
    @pivot = AppInfo.last
    @status = true
    @msg = ""
  end


  def get_cacao_msg
    @ment = CacaoMent.offset(rand(CacaoMent.count)).first.ment
    @market_url = AppInfo.last.market_url
    @appstore_url = AppInfo.last.appstore_url
    @apk = AppInfo.last.android_package_name
    @android_version = AppInfo.last.android_version
    @ios_version = AppInfo.last.ios_version
    @ipa = AppInfo.last.ios_package_name

    @android_url = "kakaolink://sendurl?msg=#{@ment}&url=#{@market_url}&appid=#{@apk}&appver=#{@android_version}"
    @ios_url = "kakaolink://sendurl?msg=#{@ment}&url=#{@appstore_url}&appid=#{@ipa}&appver=#{@ios_version}"
     

    @status = true
    @msg =""
  end

  def get_help

    if params[:page].present?
      @page = params[:page]
    else
      @page = 1
    end

    @helps = Help.order('id desc').page(@page).per(10)
    @status = true
    @msg = ""
  end

end
