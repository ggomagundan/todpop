# -*- encoding : utf-8 -*-
class Api::AdvertisesController < ApplicationController#< Api::ApplicationController

  def get_ad
 
    @status = true
    @msg = ""

    if !params[:kind].present? || !params[:nickname].present?
      @status = false
      @msg = "not exist kind or nickname parameter"
    else
      @user = User.find_by_nickname(params[:nickname])

      if !@user.present?
        @status = false
        @msg = "not exist user"
      else
        @ad_no = 1
        @content1 = "http://i.imgur.com/bmpyrJZ.jpg"
        @content2 = "http://i.imgur.com/bmpyrJZ.jpg"
      
      end

    end
 
  end
 
  def set_log

      @status = true
      @msg = ""

    if !params[:no].present? || !params[:nickname].present?
      @status = false
      @msg = "not exist no or nickname parameter"
    else
      if !User.where(:nickname => params[:nickname]).present?
        @status = false
        @msg = "user not exist"
      elsif !Advertisement.find(params[:no]).present?
        @status = false
        @msg = "advertise not exist"
      else
        @ad = AdvertiseLog.new
        @ad.advertisement_id = params[:no]
        @ad.user_id = User.find_by_nickname(params[:nickname]).id
        if params[:time].present?
          @ad.view_time = params[:time]
        end
        
        if @ad.save
          @result = true
        else
          @status = false
          @msg = "save Error"
        end

      end      

    end

  end 
  
  def get_image_ads
 
    @status = true
    @msg = ""

    if !params[:nickname].present?
      @status = false
      @msg = "not exist nickname parameter"
    else
      @user = User.find_by_nickname(params[:nickname])

      if !@user.present?
        @status = false
        @msg = "not exist user"
      else
        @ad_no = 1
        @content1 = "http://i.imgur.com/bmpyrJZ.jpg"
        @content2 = "http://i.imgur.com/bmpyrJZ.jpg"
      
        #ad_no.remain-= 1
      end

    end
 
  end


  def get_coupon_ads
 
    @status = true
    @msg = ""

    if !params[:nickname].present?
      @status = false
      @msg = "not exist nickname parameter"
    else
      @user = User.find_by_nickname(params[:nickname])

      if !@user.present?
        @status = false
        @msg = "not exist user"
      else
        @ad_no = 1
        @content1 = "http://i.imgur.com/bmpyrJZ.jpg"
        @content2 = "http://i.imgur.com/bmpyrJZ.jpg"
        @title = "토익 리스닝의 기본서"
        @subtitle = "해커스 토익\nListening Book"
        @content = "25% 할인쿠폰!"
        @original_price = "13,500원"
        @discount_price = "10,100원"
        @desc = "전국 도서매장 할인가능!!"
        @subdesc = "자세한 내용은 해커스토익 홈페이지 참조"
        @coupon_id = 11
        #ad_no.remain-= 1
      end

    end
 
  end

  def get_coupon
 
    @status = true
    @msg = ""

    if !params[:nickname].present? || !params[:coupon_id].present?
      @status = false
      @msg = "not exist nickname or coupon_id parameter"
    else
      @user = User.find_by_nickname(params[:nickname])

      if !@user.present?
        @status = false
        @msg = "not exist user"
      #elsif !@coupon.present?
        #@status = false
        #@msg = "not exist coupon"
      #elsif !@coupon.count ===0
        #@status = false
        #@msg = "no remain coupon"
      else
        @result = true
        #coupon_no.remain-= 1
      end

    end
 
  end

end
