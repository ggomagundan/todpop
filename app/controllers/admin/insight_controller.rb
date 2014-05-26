class Admin::InsightController < Admin::ApplicationController
  def index
  end
  
  def ad_analysis
    @cpd = CpdAdvertisement.all
    @cpx = CpxAdvertisement.all
    @cpdm = CpdmAdvertisement.all
  end

  def ad_analysis_detail
    error_flag = false
    @type=""
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
        tmp_ad = CpdAdvertisement.where(:id => params[:id])
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
          @all_cnt_2 = @ad.ad_type == 103 ? AdvertiseCpdLog.where("ad_id = ? and facebook_id is not null and ad_type = 103 and created_at between ? and ?", params[:id], @ad.start_date, @ad.end_date+1).count : AdvertiseCpdLog.where("ad_id = ? and act = 2 and ad_type = 102 and created_at between ? and ?", params[:id], @ad.start_date, @ad.end_date+1).count
          sd.upto(ed).each do |d|
            row = {}
            day_cnt_1 = AdvertiseCpdLog.where("ad_id = ? and created_at between ? and ?", params[:id], d, d+1).count
            added_cnt_1 += day_cnt_1
            day_cnt_2 = @ad.ad_type == 103 ? AdvertiseCpdLog.where("ad_id = ? and ad_type = 103 and facebook_id is not null and created_at between ? and ?", params[:id], d, d+1).count : AdvertiseCpdLog.where("ad_id = ? and ad_type = 102 and act = 2 and created_at between ? and ?", params[:id], d, d+1).count
            added_cnt_2 += day_cnt_2
            day_cnt_3 = @ad.ad_type == 103 ? @ad.action_price * day_cnt_2 : @ad.basic_show_price * day_cnt_1
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
        tmp_ad = CpdmAdvertisement.where("id = ?", params[:id])
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
          @all_cnt_2 = @ad.ad_type == 202 ? AdvertiseCpdmLog.where("ad_id = ? and facebook_id is not null and ad_type = 202 and created_at between ? and ?", params[:id], @ad.start_date, @ad.end_date+1).count : AdvertiseCpdmLog.where("ad_id = ? and view_time >= ? and ad_type = 201 and created_at between ? and ?", params[:id], @ad.length.to_f*0.3, @ad.start_date, @ad.end_date+1).count
          sd.upto(ed).each do |d|
            row = {}
            day_cnt_1 = AdvertiseCpdmLog.where("ad_id = ? and created_at between ? and ?", params[:id], d, d+1).count
            added_cnt_1 += day_cnt_1
            day_cnt_2 = @ad.ad_type == 202 ? AdvertiseCpdmLog.where("ad_id = ? and ad_type = 202 and facebook_id is not null and created_at between ? and ?", params[:id], d, d+1).count : AdvertiseCpdmLog.where("ad_id = ? and view_time >= ? and ad_type = 201 and created_at between ? and ?", params[:id], @ad.length.to_f*0.3, d, d+1).count
            added_cnt_2 += day_cnt_2
            day_cnt_3 = @ad.ad_type == 202 ? @ad.additional_share_price * day_cnt_2 : @ad.basic_show_price * day_cnt_1
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
        tmp_ad = CpxAdvertisement.where("id = ?", params[:id])
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
          @all_cnt_2 = AdvertiseCpxLog.where("ad_id = ? and act = 3 and created_at between ? and ?", params[:id], @ad.start_date, @ad.end_date+1).count
          sd.upto(ed).each do |d|
            row = {}
            day_cnt_1 = AdvertiseCpxLog.where("ad_id = ? and act = 1 and created_at between ? and ?", params[:id], d, d+1).count
            added_cnt_1 += day_cnt_1
            day_cnt_2 = AdvertiseCpxLog.where("ad_id = ? and act = 3 and created_at between ? and ?", params[:id], d, d+1).count
            added_cnt_2 += day_cnt_2
            day_cnt_3 = @ad.basic_show_price * day_cnt_2
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

  def reward_analysis
    @total_reward = User.sum(:total_reward)
    @current_reward = User.sum(:current_reward)

    @logs = []
      if params[:start_date].present?
        sd = Date.parse(params[:start_date])
        @tmp_reward = RewardLog.where('created_at >= ? and reward > 0', sd)
        @tmp_minus = RewardLog.where('created_at >= ? and reward < 0', sd)
      elsif params[:recent].present? && params[:recent] == 'month'
        sd = 30.day.ago.to_date
        @r = 2
        @tmp_reward = RewardLog.where('created_at >= ? and reward > 0', sd)
        @tmp_minus = RewardLog.where('created_at >= ? and reward < 0', sd)
      else
        sd = 7.day.ago.to_date
        @r = 1
        @tmp_reward = RewardLog.where('created_at >= ? and reward > 0', sd)
        @tmp_minus = RewardLog.where('created_at >= ? and reward < 0', sd)
      end

      if params[:end_date].present?
        ed = Date.parse(params[:end_date])
        @tmp_reward = @tmp_reward.where('created_at <= ? and reward > 0', ed)
        @tmp_minus = @tmp_minus.where('created_at <= ? and reward < 0', ed)
      else
        ed = Date.today
      end

      if sd > ed
        sd = 7.day.ago.to_date
        ed = Date.today
        @tmp_reward = RewardLog.where('created_at >= ? and created_at <= ? and reward > 0', sd, ed)
        @tmp_minus = RewardLog.where('created_at >= ? and created_at <= ? and reward < 0', sd, ed)
      end
      
        if params[:recent].present? && params[:recent] == 'all'
          @r = 3
          @tmp_reward = RewardLog.where('reward > 0')
          @tmp_minus = RewardLog.where('reward < 0')
          sd = RewardLog.first.created_at.to_date
          ed = Date.today
        end

        #@tmp_reward = RewardLog.all
        #if !@tmp_reward.present?
          #render :file => "#{Rails.root}/public/404"
        #else
          
          period_reward = 0
          period_minus_reward = 0
          sd.upto(ed).each do |d|
            row = {}
            day_reward = @tmp_reward.where("created_at >= ? and created_at < ?", d, d+1).sum(:reward)
            period_reward += day_reward
            day_minus_reward = @tmp_minus.where("created_at >= ? and created_at < ?", d, d+1).sum(:reward)
            period_minus_reward += day_minus_reward

            row[:day] = d
            row[:day_reward] = day_reward
            row[:period_reward] = period_reward
            row[:day_minus_reward] = day_minus_reward
            row[:period_minus_reward] = period_minus_reward

            @logs.push(row)
          end
        #end
  end

  def user_analysis
    @logs = []
    user_tmp = User.all
    @inactive_user = InactiveUser.count
    @current_user = user_tmp.count
    @fb_user = user_tmp.where(:email => nil).count
    @email_user = user_tmp.where(:facebook => nil).count
    @cross_user = @current_user - (@fb_user + @email_user)
    @total_user = @current_user + @inactive_user

    @boy = user_tmp.where(:sex => 1).count
    @girl = user_tmp.where(:sex => 2).count

    @year_1 = 0
    @year_2 = 0
    @year_3 = 0
    @year_4 = 0
    @year_5 = 0
    @year_6 = 0
    @year_7 = 0
    @year_8 = 0
    @year_9 = 0
    @year_10 = 0
    this_year = Date.today.year
    user_tmp.each do |i|
      if i.birth.present?
        year_tmp = this_year - i.birth.year
        if year_tmp < 7
          @year_1 += 1
        elsif year_tmp < 10
          @year_2 += 1
        elsif year_tmp < 13
          @year_3 += 1
        elsif year_tmp < 16
          @year_4 += 1
        elsif year_tmp < 19
          @year_5 += 1
        elsif year_tmp < 24
          @year_6 += 1
        elsif year_tmp < 29
          @year_7 += 1
        elsif year_tmp < 39
          @year_8 += 1
        elsif year_tmp < 49
          @year_9 += 1
        else
          @year_10 += 1
        end
      end
    end
    address_head_all = Address.pluck(:depth1).uniq

    @n_address=[]
    (0..address_head_all.count-1).each do |j|
      @n_address[j] = User.where('address like ?',address_head_all[j] + "%").count
    end
  end

  def ranker
    @w_logs = []

    week_end_day = Date.today.beginning_of_week-1
    last_week_record = RankingHistory.where(:end => week_end_day).where(:rank => [1,2,3,4,5])
    last_week_record.each do |i|
      w_row = {}
      week_tmp = User.find_by_id(i.user_id)
      w_row[:rank] = i.rank
      case i.rank_type
      when "week_1"
        w_row[:category] = "기초"
      when "week_2"
        w_row[:category] = "중학"
      when "week_3"
        w_row[:category] = "수능"
      else
        w_row[:category] = "토익"
      end
      w_row[:nickname] = week_tmp.nickname
      w_row[:mobile] = week_tmp.mobile
      w_row[:email] = if week_tmp.email.present? then week_tmp.email else week_tmp.facebook end
      @w_logs.push(w_row)
    end

  end

  def dau_analysis
    @logs = []

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

    if params[:recent].present? && params[:recent] == 'all'
      sd = UserTestHistory.first.created_at.to_date
      ed = Date.today
      @r = 3
    end

    test_history = UserTestHistory.all

    sd.upto(ed).each do |d|
      row = {}
      day_history = test_history.where('created_at >= ? and created_at < ?', d, d+1)
      app_info = AppInfo.last
      row[:day] = d
      row[:daily_user] = day_history.distinct.count('user_id')
      row[:test_count] = day_history.count
      row[:review_count] = day_history.where('(score >= ? and reward < ?) or (score >= ? and reward < ?)', app_info.two_medal, app_info.test_reward_max, app_info.one_medal, app_info.test_reward_max.to_i/2).count
      row[:daily_test] = row[:test_count] - row[:review_count]
      @logs.push(row)
    end

  end

  def retention
    @logs = []

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

    if params[:recent].present? && params[:recent] == 'all'
      sd = UserTestHistory.first.created_at.to_date
      ed = Date.today
      @r = 3
    end

    new_user = User.where('created_at >= ? and created_at <= ?', sd, ed)
    new_user_id = new_user.pluck(:id).uniq
    test_history = UserTestHistory.where('created_at >= ? and created_at <= ? and user_id in (?)', sd, ed, new_user_id)

    dup = []
    cnt = []

    sd.upto(ed).each do |d|
      row = {}
      date_new = new_user.where('created_at >= ? and created_at < ?', d, d+1)
      (0..12).each do |i|
        temp = test_history.where('created_at >= ? and created_at < ? and user_id in (?)', d+i, d+i+1, date_new.pluck(:id).uniq).pluck(:user_id)
        dup[i] = temp.uniq
        cnt[i] = temp.count
      end
      row[:day] = d
      row[:lt] = date_new.where('level_test > 0').count
      row[:day_0] = dup[0].count
      row[:cnt_0] = cnt[0]
      row[:user] = date_new.count
      row[:user] = 1 if date_new.count==0
      row[:day_1] = dup[1].count
      row[:cnt_1] = cnt[1]
      row[:day_2] = dup[2].count
      row[:cnt_2] = cnt[2]
      row[:day_3] = dup[3].count
      row[:cnt_3] = cnt[3]
      row[:day_4] = dup[4].count
      row[:cnt_4] = cnt[4]
      row[:day_5] = dup[5].count
      row[:cnt_5] = cnt[5]
      row[:day_6] = dup[6].count
      row[:cnt_6] = cnt[6]
      row[:day_7] = dup[7].count
      row[:cnt_7] = cnt[7]
      row[:day_8] = dup[8].count
      row[:cnt_8] = cnt[8]
      row[:day_9] = dup[9].count
      row[:cnt_9] = cnt[9]
      row[:day_10] = dup[10].count
      row[:cnt_10] = cnt[10]
      row[:day_11] = dup[11].count
      row[:cnt_11] = cnt[11]
      row[:day_12] = dup[12].count
      row[:cnt_12] = cnt[12]
=begin
      day_history = test_history.where('created_at >= ? and created_at < ?', d, d+1)
      app_info = AppInfo.last
      row[:day] = d
      row[:daily_user] = day_history.distinct.count('user_id')
      row[:test_count] = day_history.count
      row[:review_count] = day_history.where('(score >= ? and reward < ?) or (score >= ? and reward < ?)', app_info.two_medal, app_info.test_reward_max, app_info.one_medal, app_info.test_reward_max.to_i/2).count
      row[:daily_test] = row[:test_count] - row[:review_count]
=end
      @logs.push(row)
    end
  end
end
