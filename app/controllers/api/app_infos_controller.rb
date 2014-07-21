# -*- encoding : utf-8 -*-
class Api::AppInfosController < ApplicationController

  def get_fast_pivot_time
    @time = AppInfo.last.time_quick_ans
    @status = true
    @msg = ""
  end


  def get_cacao_msg
    if params[:pro].present? && params[:pro].to_i == 1
      @ment = CacaoMent.last.ment
      @img_url = ""
      @img_width = ""
      @img_height = ""
      @market_url = AppInfoPro.last.market_url
      @apk = AppInfoPro.last.android_package_name
      @android_version = AppInfoPro.last.android_version
      @android_url = "kakaolink://sendurl?msg=#{@ment}&url=#{@market_url}&appid=#{@apk}&appver=#{@android_version}"
      @android_url = 'http://market.android.com/details?id=com.todpop.saltyenglish'
    else
      @ment = CacaoMent.first.ment
      @market_url = AppInfo.last.market_url
      @appstore_url = AppInfo.last.appstore_url
      @apk = AppInfo.last.android_package_name
      @android_version = AppInfo.last.android_version
      @ios_version = AppInfo.last.ios_version
      @ipa = AppInfo.last.ios_package_name

      @android_url = "kakaolink://sendurl?msg=#{@ment}&url=#{@market_url}&appid=#{@apk}&appver=#{@android_version}"
      @ios_url = "kakaolink://sendurl?msg=#{@ment}&url=#{@appstore_url}&appid=#{@ipa}&appver=#{@ios_version}"
     
      # temp for app ver.0.1.0
      @ios_url = @ment
      #@ment = '짭짤한 영어'
      @android_url = 'http://market.android.com/details?id=com.todpop.saltyenglish'
      # --- till here ---
    end

    @status = true
    @msg =""
  end



  def get_notices
    if params[:page].present?
      @page = params[:page]
    else
      @page = 1
    end

    if params[:pro].present? && params[:pro].to_i == 1
      @notices = BoardNoticePro.order('id desc').page(@page).per(10)
    else
      @notices = BoardNotice.order('id desc').page(@page).per(10)
    end
    @status = true
    @msg = ""
  end





  def get_helps
    if params[:page].present?
      @page = params[:page]
    else
      @page = 1
    end

    if params[:pro].present? && params[:pro].to_i == 1
      @helps = BoardHelpPro.order('id desc').page(@page).per(10)
    else
      @helps = BoardHelp.order('id desc').page(@page).per(10)
    end
    @status = true
    @msg = ""
  end

end
