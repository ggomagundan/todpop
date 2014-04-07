# -*- encoding : utf-8 -*-
class Api::AdvertisesController < ApplicationController#< Api::ApplicationController
  skip_before_filter :verify_authenticity_token

  def get_cpd_ad
 
    @status = true
    @msg = ""

    if !params[:user_id].present? 
      @status = false
      @msg = "not exist params"
    else
      @user = User.find_by_id(params[:user_id])

      if !@user.present?
        @status = false
        @msg = "not exist user"
      else

        @ad_log = AdvertiseCpdLog.where('user_id = ? and created_at >= ?',@user.id, Date.today.to_time).pluck(:ad_id).uniq

        if @ad_log.length == 0
          @ad_list = CpdAdvertisement.where('priority = 1 and remain > 0 and start_date <= ? and 
                                            end_date >= ?', Date.today, Date.today)
          @ad_list_2 = CpdAdvertisement.where('priority = 2 and remain > 0 and start_date <= ? and
                                              end_date >= ?', Date.today, Date.today)
          @ad_list_3 = CpdAdvertisement.where('priority = 3 and remain > 0 and start_date <= ? and
                                              end_date >= ?', Date.today, Date.today)
          @ad_list_4 = CpdAdvertisement.where('priority = 4 and remain > 0 and start_date <= ? and 
                                              end_date >= ?', Date.today, Date.today)
          @ad_list_5 = CpdAdvertisement.where('priority = 5 and remain > 0 and start_date <= ? and
                                              end_date >= ?', Date.today, Date.today)
        else
          @ad_list = CpdAdvertisement.where('priority = 1 and id not in (?) and remain > 0 and 
                                            start_date <= ? and end_date >= ?', @ad_log, Date.today, 
                                           Date.today)
          @ad_list_2 = CpdAdvertisement.where('priority = 2 and id not in (?) and remain > 0 and 
                                              start_date <= ? and end_date >= ?', @ad_log, Date.today, 
                                             Date.today)
          @ad_list_3 = CpdAdvertisement.where('priority = 3 and id not in (?) and remain > 0 and 
                                              start_date <= ? and end_date >= ?', @ad_log, Date.today, 
                                             Date.today)
          @ad_list_4 = CpdAdvertisement.where('priority = 4 and id not in (?) and remain > 0 and 
                                              start_date <= ? and end_date >= ?', @ad_log, Date.today, 
                                             Date.today)
          @ad_list_5 = CpdAdvertisement.where('priority = 5 and remain > 0 and start_date <= ? and 
                                              end_date >= ?', Date.today, Date.today)
        end

        if(@ad_list.length != 0)
          r = 0
          r_id = 0     
          @ad_list.each do |ad|
            day = ad.end_date.to_date - Date.today
            if (ad.remain.to_f /  day.to_f) > r
              r = (ad.remain /  day.to_f)
              r_id = ad.id
            end
          end
       
        elsif(@ad_list_2.length != 0)
          r = 999990
          r_id = 0     
          @ad_list_2.each do |ad|
            day = ad.end_date.to_date - Date.today
            if day < r
              r = day
              r_id = ad.id
            end
          end
        elsif(@ad_list_3.length != 0)
          r = 0
          r_id = 0     
          @ad_list_3.each do |ad|
            day = ad.end_date.to_date - Date.today
            if (ad.remain.to_f /  day.to_f) > r
              r = (ad.remain /  day.to_f)
              r_id = ad.id
            end
         end
        elsif(@ad_list_4.length != 0)
          r = 0
          r_id = 0     
          @ad_list_4.each do |ad|
            day = ad.end_date.to_date - Date.today
            if (ad.remain.to_f /  day.to_f) > r
              r = (ad.remain /  day.to_f)
              r_id = ad.id
            end
          end
        else
          #r = 0
          #r_id = 0     
          #@ad_list_5.each do |ad|
          #  day = ad.end_date.to_date - Date.today
          #  if (ad.remain.to_f /  day.to_f) > r
          #    r = (ad.remain /  day.to_f)
          #    r_id = ad.id
          #  end
          #end

          my_ad_log = AdvertiseCpdLog.where('user_id = ? and act = ?',params[:user_id],1)
          if my_ad_log.present?
            last_ad_id = my_ad_log.last.ad_id

            # Junior Herald ad_id=3,6,7,8 ---> 3 (representative)
            if last_ad_id==3 || last_ad_id==6 || last_ad_id==7 || last_ad_id==8
              last_ad_id = 3
            end
            # --------- till here Junior Herald

            next_ad_id = CpdAdvertisement.where('id in (?) and id > ?',@ad_list_5,last_ad_id).minimum(:id)
            if next_ad_id.present?
              r_id = next_ad_id
            else
              r_id = CpdAdvertisement.where('id in (?)',@ad_list_5).minimum(:id)
            end
          else
            r_id = CpdAdvertisement.where('id in (?)',@ad_list_5).minimum(:id)
          end

        end

        if r_id == 0 || !r_id.present?
          @status = false
          @msg = "not exist ads"
        else 

          # Junior Herald case ---> r_id = 3,6,7,8
          if r_id==3
            tmp = rand(4)+1
            if tmp==1
              r_id=3
            elsif tmp==2
              r_id=6
            elsif tmp==3
              r_id=7
            else
              r_id=8
            end
          end
          # --------- till here Junior Herald


          ad = CpdAdvertisement.find_by_id(r_id)
          @msg = "success"

          @ad_id = ad.id
          @ad_type = ad.ad_type
          if @ad_type.to_i == 103
            if AdvertiseCpdLog.where('user_id = ? and ad_id = ? and act = 1 and facebook_id is not null', params[:user_id].to_i, @ad_id).size > 0
              @history = 0 #facebook shared
            else
              @history = 1
            end
          end
          @content1 = ad.front_image_url
          @content2 = ad.back_image_url

          @coupon = ad.coupon_id

          @reward = ad.reward
          @point = ad.point

          @name = ad.name
          @caption = ad.caption
          @description = ad.description
          @link = ad.link
          @picture = ad.picture

        end
      end

    end
 
  end
 
  def get_cpdm_ad
 
    @status = true
    @msg = ""

    if !params[:user_id].present?
      if !params[:list].present?
        @status = false
        @msg = "not exist params"
      else
        @list = params[:list]
        @ad_list = CpdmAdvertisement.where('remain > 0 and priority < 6 and start_date <= ? and end_date >= ?', Date.today, Date.today).pluck(:id, :url, :length, :video_ver)
      end
    else
      @user = User.find_by_id(params[:user_id])

      if !@user.present?
        @status = false
        @msg = "not exist user"
      else

        @ad_log = AdvertiseCpdmLog.where('user_id = ? and created_at >= ? and created_at <= ?',@user.id, Time.now.at_beginning_of_week, Time.now.at_end_of_week).pluck(:ad_id).uniq

        if @ad_log.length == 0
          @ad_list = CpdmAdvertisement.where('priority = 1 and remain > 0 and start_date <= ?
                                             and end_date >= ?', Date.today, Date.today)
          @ad_list_2 = CpdmAdvertisement.where('priority = 2 and remain > 0 and start_date <= ? and 
                                               end_date >= ?', Date.today, Date.today)
          @ad_list_3 = CpdmAdvertisement.where('priority = 3 and remain > 0 and start_date <= ? and 
                                               end_date >= ?', Date.today, Date.today)
          @ad_list_4 = CpdmAdvertisement.where('priority = 4 and remain > 0 and start_date <= ? and 
                                               end_date >= ?', Date.today, Date.today)
          @ad_list_5 = CpdmAdvertisement.where('priority = 5 and remain > 0 and start_date <= ? and 
                                               end_date >= ?', Date.today, Date.today)
        else
          @ad_list = CpdmAdvertisement.where('priority = 1 and id not in (?) and remain > 0 and 
                                             start_date <= ? and end_date >= ?', @ad_log, Date.today, 
                                            Date.today)
          @ad_list_2 = CpdmAdvertisement.where('priority = 2 and id not in (?) and remain > 0 and 
                                               start_date <= ? and end_date >= ?', @ad_log, Date.today, 
                                              Date.today)
          @ad_list_3 = CpdmAdvertisement.where('priority = 3 and id not in (?) and remain > 0 and 
                                               start_date <= ? and end_date >= ?', @ad_log, Date.today, 
                                              Date.today)
          @ad_list_4 = CpdmAdvertisement.where('priority = 4 and id not in (?) and remain > 0 and 
                                               start_date <= ? and end_date >= ?', @ad_log, Date.today, 
                                              Date.today)
          @ad_list_5 = CpdmAdvertisement.where('priority = 5 and remain > 0 and start_date <= ? and 
                                               end_date >= ?', Date.today, Date.today)
        end

        if(@ad_list.length != 0)
          r = 0
          r_id = 0     
          @ad_list.each do |ad|
            day = ad.end_date - Date.today
            if (ad.remain.to_f /  day.to_f) > r
              r = (ad.remain /  day.to_f)
              r_id = ad.id
            end
          end
       
        elsif(@ad_list_2.length != 0)
          r = 999990
          r_id = 0     
          @ad_list_2.each do |ad|
            day = ad.end_date - Date.today
            if day < r
              r = day
              r_id = ad.id
            end
          end
        elsif(@ad_list_3.length != 0)
          r = 0
          r_id = 0     
          @ad_list_3.each do |ad|
            day = ad.end_date - Date.today
            if (ad.remain.to_f /  day.to_f) > r
              r = (ad.remain /  day.to_f)
              r_id = ad.id
            end
         end
        elsif(@ad_list_4.length != 0)
          r = 0
          r_id = 0     
          @ad_list_4.each do |ad|
            day = ad.end_date - Date.today
            if (ad.remain.to_f /  day.to_f)> r
              r = (ad.remain /  day.to_f)
              r_id = ad.id
            end
          end
        else
          #r = 0
          #r_id = 0     
          #@ad_list_5.each do |ad|
          #  day = ad.end_date - Date.today
          #  if (ad.remain.to_f /  day.to_f) > r
          #    r = (ad.remain /  day.to_f)
          #    r_id = ad.id
          #  end
          #end

          my_ad_log = AdvertiseCpdmLog.where('user_id = ?',params[:user_id])
          if my_ad_log.present?
            last_ad_id = my_ad_log.last.ad_id
            next_ad_id = CpdmAdvertisement.where('id in (?) and id > ?',@ad_list_5,last_ad_id).minimum(:id)
            if next_ad_id.present?
              r_id = next_ad_id
            else
              r_id = CpdmAdvertisement.where('id in (?)',@ad_list_5).minimum(:id)
            end
          else
            r_id = CpdmAdvertisement.where('id in (?)',@ad_list_5).minimum(:id)
          end

        end


        if r_id == 0 || !r_id.present?
          @status = false
          @msg = "not exist ads"
        else
          ad = CpdmAdvertisement.find_by_id(r_id)
          @msg = "success"

          @ad_id = ad.id
          @ad_type = ad.ad_type
          if @ad_type.to_i == 202
            if AdvertiseCpdmLog.where('user_id = ? and ad_id = ? and act = 1 and facebook_id is not null', params[:user_id].to_i, @ad_id).size > 0
              @history = 0 #facebook shared
            else
              @history = 1
            end
          end
          @url  = ad.url
          @length = ad.length
          @video_ver = ad.video_ver

          @reward = ad.reward
          @point = ad.point

          @name = ad.name
          @caption = ad.caption
          @description = ad.description
          @link = ad.link
          @picture = ad.picture
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
      @user = User.find_by_id(params[:user_id])

      if !@user.present?
        @status = false
        @msg = "not exist user"
      else
        #@ad_log = AdvertiseCpxLog.where('user_id = ? and (act != 2 AND created_at >= ? AND created_at < ?) OR (act = 2 AND created_at >= ? AND created_at < ?)',
        #      @user.id, 14.day.ago.to_time, Time.now, 45.day.ago.to_time, Time.now).pluck(:ad_id).uniq
        
        @ad_log = AdvertiseCpxLog.where('user_id = ? and (((act = 1 OR act = 2) AND 
                                        created_at >= ?) OR ((act = 3 OR act = 4) AND 
                                        created_at >= ?))', @user.id, 14.day.ago.to_time, 
                                        45.day.ago.to_time).pluck(:ad_id).uniq


        #@ad_log = []	# test purpose by cys
        #@msg = @ad_log

        if @ad_log.length == 0
          @ad_list = CpxAdvertisement.where('priority = 1 and remain > 0 and start_date <= ? and
                                            end_date >= ?', Date.today, Date.today)
          @ad_list_2 = CpxAdvertisement.where('priority = 2 and remain > 0 and start_date <= ? and
                                              end_date >= ?', Date.today, Date.today)
          @ad_list_3 = CpxAdvertisement.where('priority = 3 and remain > 0 and start_date <= ? and
                                              end_date >= ?', Date.today, Date.today)
          @ad_list_4 = CpxAdvertisement.where('priority = 4 and remain > 0 and start_date <= ? and
                                              end_date >= ?', Date.today, Date.today)
          @ad_list_5 = CpxAdvertisement.where('priority = 5 and remain > 0 and start_date <= ? and
                                              end_date >= ?', Date.today, Date.today)
        else
          @ad_list = CpxAdvertisement.where('priority = 1 and remain > 0 and id not in (?) and 
                                            start_date <= ? and end_date >= ?', @ad_log, Date.today, 
                                            Date.today)
          @ad_list_2 = CpxAdvertisement.where('priority = 2 and remain > 0 and id not in (?) and 
                                              start_date <= ? and end_date >= ?', @ad_log, Date.today, 
                                             Date.today)
          @ad_list_3 = CpxAdvertisement.where('priority = 3 and remain > 0 and id not in (?) and 
                                              start_date <= ? and end_date >= ?', @ad_log, Date.today, 
                                             Date.today)
          @ad_list_4 = CpxAdvertisement.where('priority = 4 and remain > 0 and id not in (?) and 
                                              start_date <= ? and end_date >= ?', @ad_log, Date.today, 
                                             Date.today)
          @ad_list_5 = CpxAdvertisement.where('priority = 5 and remain > 0 and start_date <= ? and 
                                              end_date >= ? and ad_type not in (300)', Date.today, Date.today)
        end
        
        if(@ad_list.length != 0)
          r = 0
          r_id = 0     
          @ad_list.each do |ad|
            day = ad.end_date.to_date - Date.today
            if (ad.remain.to_f /  day.to_f) > r
              r = (ad.remain /  day.to_f)
              r_id = ad.id
            end
          end
       
        elsif(@ad_list_2.length != 0)
          r = 999990
          r_id = 0     
          @ad_list_2.each do |ad|
            day = ad.end_date.to_date - Date.today
            if day < r
              r = day
              r_id = ad.id
            end
          end
        elsif(@ad_list_3.length != 0)
          r = 0
          r_id = 0     
          @ad_list_3.each do |ad|
            day = ad.end_date.to_date - Date.today
            if (ad.remain.to_f /  day.to_f) > r
              r = (ad.remain /  day.to_f)
              r_id = ad.id
            end
         end
        elsif(@ad_list_4.length != 0)
          r = 0
          r_id = 0     
          @ad_list_4.each do |ad|
            day = ad.end_date.to_date - Date.today
            if (ad.remain.to_f /  day.to_f) > r
              r = (ad.remain /  day.to_f)
              r_id = ad.id
            end
          end
        elsif(@ad_list_5.length != 0)
          r = 0
          r_id = 0     
          @ad_list_5.each do |ad|
            day = ad.end_date.to_date - Date.today
            if (ad.remain.to_f / day.to_f) > r
              r = (ad.remain / day.to_f)
              r_id = ad.id
            end
          end
        elsif params[:type].present?
          ad_tmp = CpxAdvertisement.where('remain > 0 and end_date >= ? and start_date <= ?', Date.today, Date.today).pluck(:id) - AdvertiseCpxLog.where('user_id = ? and act = 3', params[:user_id].to_i).pluck(:ad_id).uniq
          if ad_tmp.length == 1
            r_id = CpxAdvertisement.where('ad_type = 300').pluck(:id).first
          else
            log = AdvertiseCpxLog.where('user_id = ? and ad_id in (?)', params[:user_id].to_i , ad_tmp).pluck(:ad_id)
            r_id = CpxAdvertisement.where('id > ? and ad_type not in (300)', log.last).first
            r_id = log.min if !r_id.present?
          end
        end


        # for Seo, YS test
        #if params[:user_id].to_i == 2
        #  r_id = 10
        #else
        #  if r_id == 10
        #    r_id = 0
        #  end
        #end
 



        if r_id == 0 || !r_id.present?
          @status = false
          @msg = "not exist ads"
        else 
          ad = CpxAdvertisement.find_by_id(r_id)
          @ad_id = ad.id
          @ad_type = ad.ad_type
          if @ad_type == 301 #CPI
            @ad_action = "다운로드"
          elsif @ad_type == 302 #CPL
            @ad_action = "좋아요"
          elsif @ad_type == 303 #CPA
            @ad_action = "참여하기"
          elsif @ad_type == 304 #CPE
            @ad_action = "실행하기"
          elsif @ad_type == 305 #CPS
            @ad_action = "설문조사"
          elsif @ad_type == 306 #CPC
            @ad_action = "구경하기"
          else
            @ad_action = "참여하기"
          end
          @ad_image = ad.ad_image_url
          @ad_text = ad.ad_text
          @target_url = ad.target_url
          @package_name = ad.package_name
          @confirm_url = ad.confirm_url
          @reward = ad.reward
          @point = ad.point
          @n_question = ad.n_question
          @msg = "success"
        end 
      end
    end
  end
  
  def set_cpd_log
    @status = true
    @msg = ""

    if !params[:ad_id].present? || !params[:ad_type].present? || !params[:user_id].present? || !params[:act].present?
      @status = false
      @msg = "lacking in params"
    elsif !(adInfo = CpdAdvertisement.find_by_id(params[:ad_id])).present? || !User.find_by_id(params[:user_id]).present?
      @status = false
      @msg = "not exist ad or user"
    elsif params[:ad_type]=="102" && params[:act]=="2" && !params[:coupon_id].present?
      @status = false
      @msg = "not exist coupon_id"
    elsif params[:ad_type]=="103" && params[:act]=="2" && !params[:facebook_id].present?
      @status = false
      @msg = "not exist facebook_id"
    end

    if @status == true
      adLog = AdvertiseCpdLog.new
      adLog.ad_id = params[:ad_id]
      adLog.ad_type = params[:ad_type]
      adLog.user_id = params[:user_id]
      adLog.act = params[:act]
      if params[:facebook_id].present?
        adLog.facebook_id = params[:facebook_id]
      end

      if adLog.save
        @msg = "success"
        @result = true
        adInfo.update_attributes(:remain => adInfo.remain - 1)
      else
        @msg = "failed to save"
        @result = false
        @status = false
      end
    end

    if @status == true && params[:act] == "2"

      if params[:ad_type] == "102"
        if MyCoupon.where(:user_id => params[:user_id].to_i, :coupon_id => params[:coupon_id].to_i).present?
          coupon = MyCoupon.where(:user_id => params[:user_id].to_i, :coupon_id => params[:coupon_id].to_i).last
          coupon.update_attributes(:updated_at => Time.now)
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
            @msg = "succeeded to write log but failed to save the coupon"
          end
        end
      end

      # reward of point
      if adInfo.reward.present? && (adInfo.reward > 0) && params[:facebook_id].present?
        @token_user_id = params[:user_id].to_i
        @token_reward_type = 6000 + params[:ad_type].to_i
        @token_title = "CPD"
        @token_sub_title = "이미지공유 etc"
        @token_reward = adInfo.reward
        process_reward_general
      end

      if adInfo.point.present? && (adInfo.point  > 0) && params[:facebook_id].present?
        @token_user_id = params[:user_id].to_i
        @token_point_type = 6000 +params[:ad_type].to_i
        @token_name = "CPD : 이미지공유 etc"
        @token_point = adInfo.point
        process_point_general
      end
      # ------

    end
  end

  def get_coupons
    @status = true
    @msg = ""

    if !params[:user_id].present? || !params[:coupon_id].present?
      @status = false
      @msg = "lacking in params"
    else
      if !User.find_by_id(params[:user_id]).present?
        @status = false
        @msg = "not exist user"
      else
        if MyCoupon.where(:user_id => params[:user_id].to_i, :coupon_id => params[:coupon_id].to_i).present?
          coupon = MyCoupon.where(:user_id => params[:user_id].to_i, :coupon_id => params[:coupon_id].to_i).last
          coupon.update_attributes(:updated_at => Time.now)
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
            @msg = "failed to save"
          end
        end
      end
    end
  end

  def set_cpdm_log
    @status = true
    @msg = ""
    if !params[:ad_id].present? || !params[:ad_type].present? || !params[:user_id].present?
      @status = false
      @msg = "lacking in params"
    elsif params[:ad_type] == "201" && !params[:view_time].present?
      @status = false
      @msg = "lacking in params (view_time)"
    elsif params[:ad_type] == "202" && ( !params[:act].present? || (!params[:view_time].present? && !params[:facebook_id].present?) )
      @status = false
      @msg = "lacking in ad_type 202 params (act, view_time or facebook_id)"
    else
      if !(adInfo = CpdmAdvertisement.find_by_id(params[:ad_id])).present? || !User.find_by_id(params[:user_id]).present?
        @status = false
        @msg = "not exist ad or user"
      else
        adLog = AdvertiseCpdmLog.new
        adLog.ad_id = params[:ad_id]
        adLog.ad_type = params[:ad_type]
        adLog.user_id = params[:user_id]
        if params[:view_time].present?
          adLog.view_time = params[:view_time]
        end
        if params[:act].present?
          adLog.act = params[:act]
        end
        if params[:facebook_id].present?
          adLog.facebook_id = params[:facebook_id]
        end

        if adLog.save
          @msg = "success"
          @result = true
          if adLog.ad_type.to_i == 201
            adInfo.update_attributes(:remain => adInfo.remain-1)
          elsif adLog.ad_type.to_i == 202 && params[:facebook_id].present?
            adInfo.update_attributes(:remain => adInfo.remain-1)
          end
          # reward or point
          if adInfo.reward.present? && (adInfo.reward > 0) && params[:facebook_id].present?
            @token_user_id = params[:user_id].to_i
            @token_reward_type = 5000 + params[:ad_type].to_i
            @token_title = "CPDM"
            @token_sub_title = "동영상공유 etc"
            @token_reward = adInfo.reward
            process_reward_general
          end

          if adInfo.point.present? && (adInfo.point  > 0) && params[:facebook_id].present?
            @token_user_id = params[:user_id].to_i
            @token_point_type = 5000 +params[:ad_type].to_i
            @token_name = "CPDM : 동영상공유 etc"
            @token_point = adInfo.point
            process_point_general
          end
          # ------

        else
          @status = false
          @msg = "failed to save"       
        end
      end
    end

  end

  def set_cpx_log
    @status = true
    @msg = ""
    if !params[:ad_id].present? || !params[:ad_type].present? || !params[:user_id].present? || !params[:act].present?
      @status = false
      @msg = "lacking in params"
    else
      if !(adInfo = CpxAdvertisement.find_by_id(params[:ad_id])).present? || !User.find_by_id(params[:user_id]).present?
        @status = false
        @msg = "not exist cpx or user"
      else
          if !AdvertiseCpxLog.where('user_id = ? and ad_id = ? and act = 3', params[:user_id].to_i, params[:ad_id].to_i).present?
        adLog = AdvertiseCpxLog.new
        adLog.ad_id = params[:ad_id]
        adLog.ad_type = params[:ad_type]
        adLog.user_id = params[:user_id]
        adLog.act = params[:act]
        if adLog.save
          @result = true
          @msg = "success"
          if params[:act].to_i==3
            adInfo.update_attributes(:remain => adInfo.remain - 1)

            # reward / point process .......
            @token_user_id = params[:user_id]
            @token_reward = adInfo.reward
            @token_point = adInfo.point
            if @token_reward.present? && @token_reward > 0 
              @token_sub_title = adInfo.ad_type.to_s + " : " + adInfo.ad_name
              @token_reward_type = 4000 + adInfo.ad_type              # reward_type : CPX = 4000 + ad_type
              @token_title = "CPX"
              process_reward_general
            elsif @token_point.present? && @token_point > 0
              @token_name = "CPX : " + adInfo.ad_type.to_s + " : " + adInfo.ad_name
              @token_point_type = 4000 + adInfo.ad_type               # point_type : CPX = 4000 + ad_type
              process_point_general
            end #reward/point process
          end #if act=3
          end #if log save success
        else
          @status = false
          @msg = "failed to save"
        end #exist act=3 log
      end #check ad and user
    end #parameter check
  end

  def cpa_return
    @status = true
    @msg = ""

    if !params[:aid].present? || !params[:mid].present?
      @status = false
      @msg = "not exist params"
      err_log = TempMin.new
      err_log.english = @msg.to_s
      err_log.koean = Time.now.to_s
      err_log.save
    else
      if !(adInfo = CpxAdvertisement.find_by_id(params[:aid])).present? || !User.find_by_id(params[:mid]).present?
        @status = false
        @msg = "not exist cpx or user"
        err_log = TempMin.new
        err_log.english = @msg.to_s
        err_log.koean = Time.now.to_s
        err_log.save
      else
        adLog = AdvertiseCpxLog.new
        adLog.ad_id = params[:aid].to_i
        adLog.ad_type = 303 #only cpa
        adLog.user_id = params[:mid]
        adLog.act = 3 #only_cpa_return
        
        if adLog.save
          @result = true
          @msg = "success"
          
          adInfo.update_attributes(:remain => adInfo.remain - 1)

            # reward / point process .......
            @token_user_id = params[:mid].to_i
            @token_reward = adInfo.reward
            @token_point = adInfo.point
            if @token_reward.present? && @token_reward > 0 
              @token_sub_title = adInfo.ad_type.to_s + " : " + adInfo.ad_name
              @token_reward_type = 4000 + adInfo.ad_type              # reward_type : CPX = 4000 + ad_type
              @token_title = "CPX"
              process_reward_general
            elsif @token_point.present? && @token_point > 0
              @token_name = "CPX : " + adInfo.ad_type.to_s + " : " + adInfo.ad_name
              @token_point_type = 4000 + adInfo.ad_type               # point_type : CPX = 4000 + ad_type
              process_point_general
            end
        else
          @status = false
          @msg = "failed to save"
          err_log = TempMin.new
          err_log.english = @msg.to_s
          err_log.koean = Time.now.to_s
          err_log.save
        end
      end

    end
  end

  def get_cps_questions
    @status = true
    @msg = ""
    if !params[:ad_id].present?
      @status = false
      @msg = "lacking in params"
    else
      questions = SurveyContent.where(:ad_id => params[:ad_id]).order("q_no ASC")
      if questions.present?
        @q_array = []
        questions.each do |q|
          tmp_hash = {}
          tmp_hash[:q_no] = q.q_no
          tmp_hash[:q_type] = q.q_type
          tmp_hash[:q_text] = q.q_text
          tmp_hash[:q_image] = q.q_image_url
          tmp_hash[:n_answer] = q.n_answer
          tmp_hash[:a1] = q.a1
          tmp_hash[:a2] = q.a2
          tmp_hash[:a3] = q.a3
          tmp_hash[:a4] = q.a4
          tmp_hash[:a5] = q.a5
          @q_array.push(tmp_hash)
        end
        @msg = "success"
      else 
        @status = false
        @msg = "not exist survey contents"
      end
    end
  end
  
  def set_survey_result
    @status = true
    @msg = ""
    if !params[:ad_id].present? || !params[:user_id].present? || !params[:ans].present?
      @status = false
      @msg = "lacking in params"
    else
      cps = CpxAdvertisement.find_by_id(params[:ad_id])
      if !cps.present? || !User.find_by_id(params[:user_id]).present?
        @status = false
        @msg = "not exist ad or user"
      elsif cps.n_question != params[:ans].size
        @status = false
        @msg = "laking in the number of answers"
      else
        res = SurveyResult.new
        res.ad_id = params[:ad_id]
        res.user_id = params[:user_id]
        params[:ans].each_with_index do |a, i|
          params[:ans][i] = " " if a == ""
        end
        res.answers = params[:ans].join("|")
        if res.save
          @msg = "success"
        else
          @status = false
          @msg = "save failed"
        end
      end
    end
  end

  def show_cpx_ad
    @status = true
    @msg = ""
    if !params[:ad_id].present?
      @status = false
      @msg = "not exist ad_id"
    end
    
    if @status == true
      if CpxAdvertisement.find_by_id(params[:ad_id]).present?
        cpx_data = CpxAdvertisement.find_by_id(params[:ad_id])
        @ad_id = cpx_data.id
        @ad_type = cpx_data.ad_type
          if @ad_type == 301 #CPI
            @ad_action = "다운로드"
          elsif @ad_type == 302 #CPL
            @ad_action = "좋아요"
          elsif @ad_type == 303 #CPA
            @ad_action = "참여하기"
          elsif @ad_type == 304 #CPE
            @ad_action = "실행하기"
          elsif @ad_type == 305 #CPS
            @ad_action = "설문조사"
          elsif @ad_type == 306 #CPC
            @ad_action = "구경하기"
          else
            @ad_action = "참여하기"
          end
        @ad_image = cpx_data.ad_image
        @ad_text = cpx_data.ad_text
        @target_url = cpx_data.target_url
        @package_name = cpx_data.package_name
        @confirm_url = cpx_data.confirm_url
        @reward = cpx_data.reward
        @point = cpx_data.point
        @n_question = cpx_data.n_question
      else
        @status = false
        @msg = "not exist ad_id"
      end
    end
  end


  def set_crosswalk_log
    @status = true
    @msg = ""

    if !params[:uid].present? || !params[:campaign_idx].present? || !params[:campaign_title].present?
      @status = false
      @msg = "not sufficient params"
    else
      uid = params[:uid].to_i
      campaign_idx = params[:campaign_idx].to_i
      campaign_title = params[:campaign_title].to_s

      @msg = uid.to_s + " / " + campaign_idx.to_s + " / " +campaign_title
    end

    if @status == true

      tmp = LogCrosswalk.new
      tmp.uid = uid
      tmp.campaign_idx = campaign_idx
      tmp.campaign_title = campaign_title
      tmp.save

    end 


  end

end
