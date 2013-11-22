class ClientController < ApplicationController
  before_filter :require_client
  helper_method :current_user
  def index
    @user = Client.find_by_id(session[:user_id])
    @cpd = CpdAdvertisement.where(:cli_id => session[:user_id])
    @cpx = CpxAdvertisement.where(:cli_id => session[:user_id])
    @cpdm = CpdmAdvertisement.where(:cli_id => session[:user_id])
  end

  def detail
    error_flag = false
    if !params[:type].present? && !params[:id].present?
      error_flag = true
    else

      @logs = []
      added_cnt_1 =0
      added_cnt_2 =0
      added_cnt_3 =0
      if params[:start_date].present?
        sd = Date.parse(params[:start_date])
      elsif params[:recent].present? && params[:recent] == 'month'
        sd = 30.day.ago.to_date
        @r = 2
      else
        sd = 7.day.ago.to_date
        @r = 1
      end

      if params[:end_date].present?
        ed = Date.parse(params[:end_date])
      else
        ed = Date.today
      end

      if sd > ed
        sd = 7.day.ago.to_date
        ed = Date.today
      end

      if params[:type] == 'cpd'
        @type = 'cpd'
        tmp_ad = CpdAdvertisement.where(:id => params[:id], :cli_id => session[:user_id])
        @ad = tmp_ad[0]
        if !@ad.present?
          render :file => "#{Rails.root}/public/404"
        else
          if params[:recent].present? && params[:recent] == 'all'
            sd = @ad.start_date
            ed = @ad.end_date
            @r = 3
          end
          if sd < @ad.start_date
            sd = @ad.start_date
          end
          if ed > @ad.end_date
            ed = @ad.end_date
          end
          if ed > Date.today
            ed = Date.today
          end
          
          @all_cnt_1 = AdvertiseCpdLog.where("ad_id = ? and created_at between ? and ?", params[:id], @ad.start_date, @ad.end_date+1).count
          @all_cnt_2 = AdvertiseCpdLog.where("ad_id = ? and act = 2 and created_at between ? and ?", params[:id], @ad.start_date, @ad.end_date+1).count
          sd.upto(ed).each do |d|
            row = {}
            day_cnt_1 = AdvertiseCpdLog.where("ad_id = ? and created_at between ? and ?", params[:id], d, d+1).count
            added_cnt_1 += day_cnt_1
            day_cnt_2 = AdvertiseCpdLog.where("ad_id = ? and act = 2 and created_at between ? and ?", params[:id], d, d+1).count
            added_cnt_2 += day_cnt_2
            day_cnt_3 = @ad.unit_price * day_cnt_1
            added_cnt_3 += day_cnt_3
            row[:day] = d
            row[:day_cnt_1] = day_cnt_1
            row[:added_cnt_1] = added_cnt_1
            row[:day_cnt_2] = day_cnt_2
            row[:added_cnt_2] =  added_cnt_2
            row[:day_cnt_3] = day_cnt_3
            row[:added_cnt_3] = added_cnt_3
            @logs.push(row)
          end
        end

      elsif params[:type] == 'cpdm'
        @type = 'cpdm'
        tmp_ad = CpdmAdvertisement.where("id = ? and cli_id = ?", params[:id], session[:user_id])
        @ad = tmp_ad[0]
        if !@ad.present?
          render :file => "#{Rails.root}/public/404"
        else
          if sd < @ad.start_date
            sd = @ad.start_date
          end
          if ed > @ad.end_date
            ed = @ad.end_date
          end
          @all_cnt_1 = AdvertiseCpdmLog.where("ad_id = ? and created_at between ? and ?", params[:id], @ad.start_date, @ad.end_date+1).count
          @all_cnt_2 = AdvertiseCpdmLog.where("ad_id = ? and view_time >= ? and created_at between ? and ?", params[:id], @ad.length*0.3, @ad.start_date, @ad.end_date+1).count
          sd.upto(ed).each do |d|
            row = {}
            day_cnt_1 = AdvertiseCpdmLog.where("ad_id = ? and created_at between ? and ?", params[:id], d, d+1).count
            added_cnt_1 += day_cnt_1
            day_cnt_2 = AdvertiseCpdmLog.where("ad_id = ? and view_time >= ? and created_at between ? and ?", params[:id], @ad.length*0.3, d, d+1).count
            added_cnt_2 += day_cnt_2
            day_cnt_3 = @ad.unit_price * day_cnt_1
            added_cnt_3 += day_cnt_3
            row[:day] = d
            row[:day_cnt_1] = day_cnt_1
            row[:added_cnt_1] = added_cnt_1
            row[:day_cnt_2] = day_cnt_2
            row[:added_cnt_2] =  added_cnt_2
            row[:day_cnt_3] = day_cnt_3
            row[:added_cnt_3] = added_cnt_3
            @logs.push(row)
          end
        end

      elsif params[:type] == 'cpx'
        @type = 'cpx'
        tmp_ad = CpxAdvertisement.where("id = ? and cli_id = ?", params[:id], session[:user_id])
        @ad = tmp_ad[0]
        if !@ad.present?
          render :file => "#{Rails.root}/public/404"
        else
          if sd < @ad.start_date
            sd = @ad.start_date
          end
          if ed > @ad.end_date
            ed = @ad.end_date
          end
          @all_cnt_1 = AdvertiseCpxLog.where("ad_id = ? and act = 1 and created_at between ? and ?", params[:id], @ad.start_date, @ad.end_date+1).count
          @all_cnt_2 = AdvertiseCpxLog.where("ad_id = ? and act = 2 and created_at between ? and ?", params[:id], @ad.start_date, @ad.end_date+1).count
          sd.upto(ed).each do |d|
            row = {}
            day_cnt_1 = AdvertiseCpxLog.where("ad_id = ? and act = 1 and created_at between ? and ?", params[:id], d, d+1).count
            added_cnt_1 += day_cnt_1
            day_cnt_2 = AdvertiseCpxLog.where("ad_id = ? and act = 2 and created_at between ? and ?", params[:id], d, d+1).count
            added_cnt_2 += day_cnt_2
            day_cnt_3 = @ad.unit_price * day_cnt_1
            added_cnt_3 += day_cnt_3
            row[:day] = d
            row[:day_cnt_1] = day_cnt_1
            row[:added_cnt_1] = added_cnt_1
            row[:day_cnt_2] = day_cnt_2
            row[:added_cnt_2] =  added_cnt_2
            row[:day_cnt_3] = day_cnt_3
            row[:added_cnt_3] = added_cnt_3
            @logs.push(row)
          end
        end
      else
        render :file => "#{Rails.root}/public/404"
      end

    end
  end

  private
  def require_client
    if !current_user.present?
      redirect_to new_session_path
    end
  end

  def current_user
    @current_user ||= session[:user_id] && Client.find_by_id(session[:user_id]) 
  end
end
