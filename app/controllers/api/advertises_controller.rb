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


end
