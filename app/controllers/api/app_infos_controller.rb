# -*- encoding : utf-8 -*-
class Api::AppInfosController < ApplicationController

  def get_fast_pivot_time
    @time = AppInfo.last.time_quick_ans
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
     

    @ios_url = @ment
    @ment = '짭짤한 영어'
    @android_url = '잠시만요'


    @status = true
    @msg =""
  end



  def get_notices
    if params[:page].present?
      @page = params[:page]
    else
      @page = 1
    end
    @notices = BoardNotice.order('id desc').page(@page).per(10)
    @status = true
    @msg = ""
  end





  def get_helps
    if params[:page].present?
      @page = params[:page]
    else
      @page = 1
    end

    @helps = BoardHelp.order('id desc').page(@page).per(10)
    @status = true
    @msg = ""
  end

end
