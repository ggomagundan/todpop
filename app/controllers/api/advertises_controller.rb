# -*- encoding : utf-8 -*-
class Api::AdvertisesController < ApplicationController#< Api::ApplicationController

  def get_ad
  end

  def get_cpd_ad
 
    @status = true
    @msg = ""

    if !params[:user_id].present? 
      @status = false
      @msg = "not exist params"
    else
      @user = User.find(params[:user_id])

      if !@user.present?
        @status = false
        @msg = "not exist user"
      else

        @ad_log = AdvertiseCpdLog.where('user_id = ? and created_at >= ?',@user.id, Date.today.to_time).pluck(:ad_id).uniq

        if @ad_log.length == 0
          @ad_list = CpdAdvertisement.where(:priority => 1)
          @ad_list_2 = CpdAdvertisement.where(:priority => 2 )
          @ad_list_3 = CpdAdvertisement.where(:priority => 3 )
          @ad_list_4 = CpdAdvertisement.where(:priority => 4)
          @ad_list_5 = CpdAdvertisement.where(:priority => 5)
        else
          @ad_list = CpdAdvertisement.where('priority = 1 and id not in (?)',@ad_log)
          @ad_list_2 = CpdAdvertisement.where('priority = 2 and id not in (?)',@ad_log)
          @ad_list_3 = CpdAdvertisement.where('priority = 3 and id not in (?)',@ad_log)
          @ad_list_4 = CpdAdvertisement.where('priority = 4 and id not in (?)',@ad_log)
          @ad_list_5 = CpdAdvertisement.where('priority = 5')
        end

        if(@ad_list.length != 0)
          r = 0
          r_id = 0     
          @ad_list.each do |ad|
            day = ad.end_time.to_date - Date.today
            if (ad.remain /  day.to_f) > r
              r = (ad.remain /  day.to_f)
              r_id = ad.id
            end
          end
       
        elsif(@ad_list_2.length != 0)
          r = 999990
          r_id = 0     
          @ad_list_2.each do |ad|
            day = ad.end_time.to_date - Date.today
            if day < r
              r = day
              r_id = ad.id
            end
          end
        elsif(@ad_list_3.length != 0)
          r = 0
          r_id = 0     
          @ad_list_3.each do |ad|
            day = ad.end_time.to_date - Date.today
            if (ad.remain /  day.to_f) > r
              r = (ad.remain /  day.to_f)
              r_id = ad.id
            end
         end
        elsif(@ad_list_4.length != 0)
          r = 0
          r_id = 0     
          @ad_list_4.each do |ad|
            day = ad.end_time.to_date - Date.today
            if (ad.remain /  day.to_f) > r
              r = (ad.remain /  day.to_f)
              r_id = ad.id
            end
          end
        else
          r = 0
          r_id = 0     
          @ad_list_5.each do |ad|
            day = ad.end_time.to_date - Date.today
            if (ad.remain /  day.to_f) > r
              r = (ad.remain /  day.to_f)
              r_id = ad.id
            end
          end

        end

        if r_id == 0
          @status = false
          @msg = "not exit ads"
        else 
          ad = CpdAdvertisement.find(r_id)
          @ad_id = ad.id
          @ad_type = ad.ad_type
          @content1 = ad.front_image_url
          @content2 = ad.back_image_url
          @coupon = ad.coupon_id
          @msg = "success"
        end
      end

    end
 
  end
 
  def get_cpdm_ad
 
    @status = true
    @msg = ""

    if !params[:user_id].present? 
      @status = false
      @msg = "not exist params"
    else
      @user = User.find(params[:user_id])

      if !@user.present?
        @status = false
        @msg = "not exist user"
      else

        @ad_log = AdvertiseCpdmLog.where('user_id = ? and created_at >= ?',@user.id, Date.today.to_time).pluck(:ad_id).uniq

        if @ad_log.length == 0
          @ad_list = CpdmAdvertisement.where(:priority => 1)
          @ad_list_2 = CpdmAdvertisement.where(:priority => 2 )
          @ad_list_3 = CpdmAdvertisement.where(:priority => 3 )
          @ad_list_4 = CpdmAdvertisement.where(:priority => 4)
          @ad_list_5 = CpdmAdvertisement.where(:priority => 5)
        else
          @ad_list = CpdmAdvertisement.where('priority = 1 and id not in (?)',@ad_log)
          @ad_list_2 = CpdmAdvertisement.where('priority = 2 and id not in (?)',@ad_log)
          @ad_list_3 = CpdmAdvertisement.where('priority = 3 and id not in (?)',@ad_log)
          @ad_list_4 = CpdmAdvertisement.where('priority = 4 and id not in (?)',@ad_log)
          @ad_list_5 = CpdmAdvertisement.where('priority = 5')
        end

        if(@ad_list.length != 0)
          r = 0
          r_id = 0     
          @ad_list.each do |ad|
            day = ad.end_time - Date.today
            if (ad.remain /  day.to_f) > r
              r = (ad.remain /  day.to_f)
              r_id = ad.id
            end
          end
       
        elsif(@ad_list_2.length != 0)
          r = 999990
          r_id = 0     
          @ad_list_2.each do |ad|
            day = ad.end_time - Date.today
            if day < r
              r = day
              r_id = ad.id
            end
          end
        elsif(@ad_list_3.length != 0)
          r = 0
          r_id = 0     
          @ad_list_3.each do |ad|
            day = ad.end_time - Date.today
            if (ad.remain /  day.to_f) > r
              r = (ad.remain /  day.to_f)
              r_id = ad.id
            end
         end
        elsif(@ad_list_4.length != 0)
          r = 0
          r_id = 0     
          @ad_list_4.each do |ad|
            day = ad.end_time - Date.today
            if (ad.remain /  day.to_f)> r
              r = (ad.remain /  day.to_f)
              r_id = ad.id
            end
          end
        else
          r = 0
          r_id = 0     
          @ad_list_5.each do |ad|
            day = ad.end_time - Date.today
            if (ad.remain /  day.to_f) > r
              r = (ad.remain /  day.to_f)
              r_id = ad.id
            end
          end

        end


        if r_id == 0
          @status = false
          @msg = "not exit ads"
        else 
          ad = CpdmAdvertisement.find(r_id)
          @ad_id = ad.id
          @ad_type = ad.ad_type
          @url  = ad.url
          @length = ad.length
          @msg = "success"
        end

      
      end

    end
  end

 
   def get_cpx_ad

    @status = true
    @msg = ""

    if !params[:user_id].present? 
      @status = false
      @msg = "not exist params"
    else
      @user = User.find(params[:user_id])

      if !@user.present?
        @status = false
        @msg = "not exist user"
      else

        @ad_log = AdvertiseCpxLog.where('user_id = ? and created_at >= ?',@user.id, Date.today.to_time).pluck(:ad_id).uniq

        if @ad_log.length == 0
          @ad_list = CpxAdvertisement.where(:priority => 1)
          @ad_list_2 = CpxAdvertisement.where(:priority => 2 )
          @ad_list_3 = CpxAdvertisement.where(:priority => 3 )
          @ad_list_4 = CpxAdvertisement.where(:priority => 4)
          @ad_list_5 = CpxAdvertisement.where(:priority => 5)
        else
          @ad_list = CpxAdvertisement.where('priority = 1 and id not in (?)',@ad_log)
          @ad_list_2 = CpxAdvertisement.where('priority = 2 and id not in (?)',@ad_log)
          @ad_list_3 = CpxAdvertisement.where('priority = 3 and id not in (?)',@ad_log)
          @ad_list_4 = CpxAdvertisement.where('priority = 4 and id not in (?)',@ad_log)
          @ad_list_5 = CpxAdvertisement.where('priority = 5')
        end


        if(@ad_list.length != 0)
          r = 0
          r_id = 0     
          @ad_list.each do |ad|
            day = ad.end_time.to_date - Date.today
            if (ad.remain /  day.to_f) > r
              r = (ad.remain /  day.to_f)
              r_id = ad.id
            end
          end
       
        elsif(@ad_list_2.length != 0)
          r = 999990
          r_id = 0     
          @ad_list_2.each do |ad|
            day = ad.end_time.to_date - Date.today
            if day < r
              r = day
              r_id = ad.id
            end
          end
        elsif(@ad_list_3.length != 0)
          r = 0
          r_id = 0     
          @ad_list_3.each do |ad|
            day = ad.end_time.to_date - Date.today
            if (ad.remain /  day.to_f) > r
              r = (ad.remain /  day.to_f)
              r_id = ad.id
            end
         end
        elsif(@ad_list_4.length != 0)
          r = 0
          r_id = 0     
          @ad_list_4.each do |ad|
            day = ad.end_time.to_date - Date.today
            if (ad.remain /  day.to_f) > r
              r = (ad.remain /  day.to_f)
              r_id = ad.id
            end
          end
        else
          r = 0
          r_id = 0     
          @ad_list_5.each do |ad|
            day = ad.end_time.to_date - Date.today
            if (ad.remain /  day.to_f) > r
              r = (ad.remain /  day.to_f)
              r_id = ad.id
            end
          end

        end

        if r_id == 0
          @status = false
          @msg = "not exit ads"
        else 
          ad = CpxAdvertisement.find(r_id)
          @ad_id = ad.id
          @ad_type = ad.ad_type
          @ad_image = ad.ad_image_url
          @ad_text = ad.ad_text
          @store_url = ad.store_url
          @package_name = ad.package_name
          @confirm_url = ad.confirm_url
          @reward = ad.reward
          @n_question = ad.n_question
          @msg = "success"
        end

      
      end


    end

   end

  def set_cpx_log

      @status = true
      @msg = ""

    if !params[:no].present? || !params[:nickname].present? || !params[:type]
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
        @ad.view_time = 1
        
        if @ad.save
          @result = true
        else
          @status = false
          @msg = "save Error"
        end

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

  def set_cpd_log
    @status = true
    @msg = ""

    if !params[:ad_id].present? || !params[:ad_type].present? || !params[:user_id].present? || !params[:action].present?
      @status = false
      @msg = "lacking in params"
    else
      adLog = AdvertiseCpdLog.new
      adLog.ad_id = params[:ad_id]
      adLog.ad_type = params[:ad_type]
      adLog.user_id = params[:user_id]
      adLog.action = params[:action]
      if adLog.save
        @msg = "success"
        @result = true
      else
        @msg = "failed to save"
        @result = false
        @status = false
      end
    end
  end

  def get_coupons
    @status = true
    @msg = ""

    if !params[:user_id].present? || !params[:coupon_id].present?
      @status = false
      @msg = "lacking in params"
    else
      new_coupon = MyCoupon.new
      new_coupon.user_id = params[:user_id]
      new_coupon.coupon_id = params[:coupon_id]
      new_coupon.coupon_type = 0  # 0 - free, 1 - not free
      if new_coupon.save
        @result = true
        @msg = "success"
      else
        @status = false
        @result = false
        @msg = "failed to save"
      end
    end
  end

  def set_cpdm_log
    @status = true
    @msg = ""
    if !params[:ad_id].present? || !params[:ad_type].present? || !params[:user_id].present? || !params[:view_time].present?
      @status = false
      @msg = "lacking in params"
    else
      adLog = AdvertiseCpdmLog.new
      adLog.ad_id = params[:ad_id]
      adLog.ad_type = params[:ad_type]
      adLog.user_id = params[:user_id]
      adLog.view_time = params[:view_time]
      if adLog.save
        @msg = "success"
        @result = true
      else
        @msg = "failed to save"
        @result = false
        @status = false
      end
    end

  end

  def set_cpx_log
    @status = true
    @msg = ""
    if !params[:ad_id].present? || !params[:ad_type].present? || !params[:user_id].present? || !params[:view_time].present?
      @status = false
      @msg = "lacking in params"
    else
      adLog = AdvertiseCpxLog.new
      adLog.ad_id = params[:ad_id]
      adLog.ad_type = params[:ad_type]
      adLog.user_id = params[:user_id]
      adLog.action = params[:action]
      if adLog.save
        @msg = "success"
        @result = true
      else
        @msg = "failed to save"
        @result = false
        @status = false
      end
    end

  end
 
end
