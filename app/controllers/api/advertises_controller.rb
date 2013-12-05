# -*- encoding : utf-8 -*-
class Api::AdvertisesController < ApplicationController#< Api::ApplicationController

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
          @ad_list = CpdAdvertisement.where(:priority => 1)
          @ad_list_2 = CpdAdvertisement.where(:priority => 2)
          @ad_list_3 = CpdAdvertisement.where(:priority => 3)
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
            day = ad.end_date.to_date - Date.today
            if (ad.remain /  day.to_f) > r
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
            if (ad.remain /  day.to_f) > r
              r = (ad.remain /  day.to_f)
              r_id = ad.id
            end
         end
        elsif(@ad_list_4.length != 0)
          r = 0
          r_id = 0     
          @ad_list_4.each do |ad|
            day = ad.end_date.to_date - Date.today
            if (ad.remain /  day.to_f) > r
              r = (ad.remain /  day.to_f)
              r_id = ad.id
            end
          end
        else
          r = 0
          r_id = 0     
          @ad_list_5.each do |ad|
            day = ad.end_date.to_date - Date.today
            if (ad.remain /  day.to_f) > r
              r = (ad.remain /  day.to_f)
              r_id = ad.id
            end
          end

        end

        if r_id == 0
          @status = false
          @msg = "not exist ads"
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
      @user = User.find_by_id(params[:user_id])

      if !@user.present?
        @status = false
        @msg = "not exist user"
      else

        @ad_log = AdvertiseCpdmLog.where('user_id = ? and created_at >= ? and created_at <= ?',@user.id, Time.now.at_beginning_of_week, Time.now.at_end_of_week).pluck(:ad_id).uniq

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
            day = ad.end_date - Date.today
            if (ad.remain /  day.to_f) > r
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
            if (ad.remain /  day.to_f) > r
              r = (ad.remain /  day.to_f)
              r_id = ad.id
            end
         end
        elsif(@ad_list_4.length != 0)
          r = 0
          r_id = 0     
          @ad_list_4.each do |ad|
            day = ad.end_date - Date.today
            if (ad.remain /  day.to_f)> r
              r = (ad.remain /  day.to_f)
              r_id = ad.id
            end
          end
        else
          r = 0
          r_id = 0     
          @ad_list_5.each do |ad|
            day = ad.end_date - Date.today
            if (ad.remain /  day.to_f) > r
              r = (ad.remain /  day.to_f)
              r_id = ad.id
            end
          end

        end


        if r_id == 0
          @status = false
          @msg = "not exist ads"
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
      @user = User.find_by_id(params[:user_id])

      if !@user.present?
        @status = false
        @msg = "not exist user"
      else
        @ad_log = AdvertiseCpxLog.where('user_id = ? and (act != 2 AND created_at >= ? AND created_at < ?) OR (act = 2 AND created_at >= ? AND created_at < ?)',
              @user.id, 14.day.ago.to_time, Time.now, 45.day.ago.to_time, Time.now).pluck(:ad_id).uniq

@ad_log = []	# test purpose by cys


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
            day = ad.end_date.to_date - Date.today
            if (ad.remain /  day.to_f) > r
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
            if (ad.remain /  day.to_f) > r
              r = (ad.remain /  day.to_f)
              r_id = ad.id
            end
         end
        elsif(@ad_list_4.length != 0)
          r = 0
          r_id = 0     
          @ad_list_4.each do |ad|
            day = ad.end_date.to_date - Date.today
            if (ad.remain /  day.to_f) > r
              r = (ad.remain /  day.to_f)
              r_id = ad.id
            end
          end
        else
          r = 0
          r_id = 0     
          @ad_list_5.each do |ad|
            day = ad.end_date.to_date - Date.today
            if (ad.remain /  day.to_f) > r
              r = (ad.remain /  day.to_f)
              r_id = ad.id
            end
          end

        end

        if r_id == 0
          @status = false
          @msg = "not exist ads"
        else 
          ad = CpxAdvertisement.find(r_id)
          @ad_id = ad.id
          @ad_type = ad.ad_type
          @ad_image = ad.ad_image_url
          @ad_text = ad.ad_text
          @target_url = ad.target_url
          @package_name = ad.package_name
          @confirm_url = ad.confirm_url
          @reward = ad.reward
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
    else
      if !(adInfo = CpdAdvertisement.find_by_id(params[:ad_id])).present? || !User.find_by_id(params[:user_id]).present?
        @status = false
        @msg = "not exist cpd or user"
      else
        adLog = AdvertiseCpdLog.new
        adLog.ad_id = params[:ad_id]
        adLog.ad_type = params[:ad_type]
        adLog.user_id = params[:user_id]
        adLog.act = params[:act]
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

  def set_cpdm_log
    @status = true
    @msg = ""
    if !params[:ad_id].present? || !params[:ad_type].present? || !params[:user_id].present? || !params[:view_time].present?
      @status = false
      @msg = "lacking in params"
    else
      if !(adInfo = CpdmAdvertisement.find_by_id(params[:ad_id])).present? || !User.find_by_id(params[:user_id]).present?
        @status = false
        @msg = "not exist cpx or user"
      else
        adLog = AdvertiseCpdmLog.new
        adLog.ad_id = params[:ad_id]
        adLog.ad_type = params[:ad_type]
        adLog.user_id = params[:user_id]
        adLog.view_time = params[:view_time]
        if adLog.save
          @msg = "success"
          @result = true
          adInfo.update_attributes(:remain => adInfo.remain-1)
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

            # reward process .......
            @token_user_id = params[:user_id]
            @token_reward_type = 4000 + adInfo.ad_type              # reward_tpye : CPX = 4000 + ad_type
            @token_title = "CPX"
            @token_sub_title = adInfo.ad_type.to_s + " : " + adInfo.ad_name
            @token_reward = adInfo.unit_price
            process_reward_general

          end
        else
          @status = false
          @msg = "failed to save"
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
      if !CpxAdvertisement.find_by_id(params[:ad_id]).present?
        cpx_data = CpxAdvertisement.find_by_id(params[:ad_id])
        @ad_id = cpx_data.id
        @ad_type = cpx_data.ad_type
        @ad_image = cpx_data.ad_image
        @ad_text = cpx_data.ad_text
        @target_url = cpx_data.target_url
        @package_name = cpx_data.package_name
        @confirm_url = cpx_data.confirm_url
        @reward = cpx_data.reward
        @n_question = cpx_data.n_question
      end
    end
  end

end
